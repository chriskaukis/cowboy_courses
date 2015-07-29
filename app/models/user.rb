require 'digest/sha1'

class User < ActiveRecord::Base
  PHONE_FORMAT = /[0-9]{10,10}/
  
  has_many :subscriptions
  has_many :sections, :through => :subscriptions
  has_many :comments
  has_many :votes
  
  validate :validate_identity_url
  validates_uniqueness_of :identity_url
  validates_uniqueness_of :email, :if => :email_required?
  validates_presence_of :email, :if => :email_required?, :message => 'is required if you select email notifications'
  validates_presence_of :phone, :if => :phone_required?, :message => 'is required if you select a carrier or sms notifications'
  validates_format_of :phone, :if => :phone_required?, :with => PHONE_FORMAT, :message => 'must be a valid 10 digit number'
  
  after_validation_on_create :set_default_name
  after_update :update_subscription_notifications
  
  def formatted_phone
    if phone =~ /([0-9]{3,3})([0-9]{3,3})([0-9]{4,4})/
      "#{$1}-#{$2}-#{$3}"
    else
      self.phone
    end
  end
  
  # Virtual like attribute thing used for form input.
  # Given something like 405------612---8-0-  0-8-----
  # sets phone to 4056128008
  # removes everything except a number (duh!) as you can see by the 
  # regular expression. Just wasted 5 lines of comments.
  def formatted_phone=(phone)
    self.phone = phone.gsub(/[^0-9]+/, '') unless phone.blank?    
  end
  
  def notification_emails
    emails = []
    emails << self.email if self.email_notification? && !self.email.blank?
    emails << self.sms_email if self.sms_notification? && !self.sms_email.blank?
    return emails
  end
  
  def sms_email
    if has_sms?
      "#{self.phone}#{SMS_CONFIG['carriers'][self.carrier]['value']}"
    else
      nil
    end
  end
  
  def enable_api!
    self.api_key = self.class.generate_api_key(self)
    save!
  end
  
  def disable_api!
    self.api_key = nil
    save!
  end
  
  def api_enabled?
    return !self.api_key.blank?
  end

  # Generates an API key for a user.
  # Just some random key thing no one would be able to guess that is unique to the user.
  # I'll take my chances.
  def self.generate_api_key(user)
    return Digest::SHA1.hexdigest("#{Time.now}-#{user.id}-#{user.identity_url}")
  end
  
  def subscribed_to?(section)
    @cached_section_ids ||= section_ids
    @cached_section_ids.include?(section.id)    
  end
  
  def up_voted?(voteable)
    if voteable.is_a?(Course)
      @up_voted_course_ids ||= connection.select_values("SELECT voteable_id FROM votes WHERE voteable_type = 'Course' AND user_id = #{id} AND points > 0")
      return @up_voted_course_ids.include?(voteable.id.to_s)
    elsif voteable.is_a?(Instructor)
      @up_voted_instructor_ids ||= connection.select_values("SELECT voteable_id FROM votes WHERE voteable_type = 'Instructor' AND user_id = #{id} AND points > 0")
      return @up_voted_instructor_ids.include?(voteable.id.to_s)
    end
  end
  
  def down_voted?(voteable)
    if voteable.is_a?(Course)
      @down_voted_course_ids ||= connection.select_values("SELECT voteable_id FROM votes WHERE voteable_type = 'Course' AND user_id = #{id} AND points < 0")
      @down_voted_course_ids.include?(voteable.id.to_s)
    elsif voteable.is_a?(Instructor)
      @down_voted_instructor_ids ||= connection.select_values("SELECT voteable_id FROM votes WHERE voteable_type = 'Instructor' AND user_id = #{id} AND points < 0")
      @down_voted_instructor_ids.include?(voteable.id.to_s)
    end
  end
  
  protected
  
    # SMS is valid if we have a valid carrier and phone format.
    def has_sms?
      carrier_valid? && phone_valid?
    end

    # Carrier exists?
    def carrier_valid?
      !self.carrier.blank? && SMS_CONFIG['carriers'].has_key?(self.carrier)
    end
  
    # Check the phone is valid.
    def phone_valid?
      self.phone =~ PHONE_FORMAT
    end
    
    # Keep the subscriptions notification options in sync until we
    # implement option to update on a per subscription basis.
    def update_subscription_notifications
      self.class.update_subscription_notifications(self) if self.status_notification_changed? || self.instructor_notification_changed?
    end
  
    def self.update_subscription_notifications(user)
      sql = <<-SQL
        UPDATE subscriptions SET 
          status_notification = ?, 
          instructor_notification = ?
        WHERE user_id = ?
      SQL
      connection.update_sql(sanitize_sql_for_conditions([sql, user.status_notification?, user.instructor_notification?, user.id]))
    end
    
    def set_default_name
      names = self.identity_url.split('/')
      if names.length > 2
        domains = names.split('.')
        if domains.length >= 2
          self.name = domains[-2]
        else
          self.name = names[2]
        end
      else
        self.name = 'Joe Cool'
      end
    end
  
    # Email is required if they want to receive email notifications.
    def email_required?
      self.email_notification? || !self.email.blank?
    end
    
    # Phone is required if they choose a carrier or choose SMS notifications.
    def phone_required?
      !self.carrier.blank? || self.sms_notification? || !self.phone.blank?
    end
  
    def validate_identity_url
      begin
        self.identity_url = OpenIdAuthentication.normalize_identifier(self.identity_url)
      rescue OpenIdAuthentication::InvalidOpenId => error
        errors.add(:identity_url, 'looks like shit, fix it')
      end
    end
end
