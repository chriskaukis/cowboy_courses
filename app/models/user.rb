class User < ActiveRecord::Base
  has_secure_password
  validates :name, presence: true
  validates :email, presence: true, uniqueness: { case_sensitive: false }
  validates :password, length: { minimum: 6 }

  attr_accessor :remember_token, :activation_token

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

  protected

    def downcase_email
      email.downcase!
    end

    def create_activation_digest
      self.activation_token = User.generate_token
      self.activation_digest = User.digest(activation_token)
    end
end
