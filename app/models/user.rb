class User < ActiveRecord::Base
  has_secure_password

  has_many :subscriptions
  has_many :sections, :through => :subscriptions
  has_many :comments
  has_many :votes

  validates :name, presence: true
  validates :email, presence: true, uniqueness: { case_sensitive: false }
  validates :password, length: { minimum: 6 }, unless: Proc.new { |r| r.password.blank? }

  attr_accessor :remember_token, :activation_token, :password_reset_token

  before_create :create_activation_digest
  before_save :downcase_email

  def self.generate_token
    SecureRandom.urlsafe_base64
  end

  def self.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  def remember!
    self.remember_token = User.generate_token
    update_attribute(:remember_digest, User.digest(self.remember_token))
  end

  def remembered?(token)
    return false if remember_digest.nil?
    BCrypt::Password.new(remember_digest).is_password?(token)
  end

  def activate!(token)
    return true if activated?
    valid_token = BCrypt::Password.new(activation_digest).is_password?(token)
    update_attributes({ activated: true, activated_at: Time.zone.now, activation_digest: nil }) if valid_token
    return valid_token
  end

  def forget!
    update_attribute(:remember_digest, nil)
  end

  def create_password_reset_digest
    self.password_reset_token = User.generate_token
    self.password_reset_digest = User.digest(self.password_reset_token)
    self.password_reset_sent_at = Time.zone.now
    save
  end

  def is_valid_password_reset_token?(token)
    BCrypt::Password.new(password_reset_digest).is_password?(token)
  end

  def password_reset_expired?
    password_reset_sent_at < 1.day.ago
  end

  def subscribed_to?(section)
    @cached_section_ids ||= section_ids
    @cached_section_ids.include?(section.id)    
  end
  
  def up_voted?(voteable)
    if voteable.is_a?(Course)
      @up_voted_course_ids ||= ActiveRecord::Base.connection.select_values("SELECT voteable_id FROM votes WHERE voteable_type = 'Course' AND user_id = #{id} AND points > 0")
      return @up_voted_course_ids.include?(voteable.id.to_s)
    elsif voteable.is_a?(Instructor)
      @up_voted_instructor_ids ||= ActiveRecord::Base.connection.select_values("SELECT voteable_id FROM votes WHERE voteable_type = 'Instructor' AND user_id = #{id} AND points > 0")
      return @up_voted_instructor_ids.include?(voteable.id.to_s)
    end
  end
  
  def down_voted?(voteable)
    if voteable.is_a?(Course)
      @down_voted_course_ids ||= ActiveRecord::Base.connection.select_values("SELECT voteable_id FROM votes WHERE voteable_type = 'Course' AND user_id = #{id} AND points < 0")
      @down_voted_course_ids.include?(voteable.id.to_s)
    elsif voteable.is_a?(Instructor)
      @down_voted_instructor_ids ||= ActiveRecord::Base.connection.select_values("SELECT voteable_id FROM votes WHERE voteable_type = 'Instructor' AND user_id = #{id} AND points < 0")
      @down_voted_instructor_ids.include?(voteable.id.to_s)
    end
  end

  protected

    def downcase_email
      email.downcase!
    end

    def create_activation_digest
      self.activation_token = User.generate_token
      self.activation_digest = User.digest(activation_token)
    end
end
