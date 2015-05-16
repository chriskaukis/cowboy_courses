class Session
  include ActiveModel::Model

  attr_accessor :email, :password, :return_url, :remember

  validates :email, presence: true
  validates :password, presence: true

  def authenticate!
    if valid?
      user = User.find_by(email: email).try(:authenticate, password)
      return user if !user.nil? && user.activated?
      if user.nil?
        errors.add(:base, 'Invalid username and/or password.')
      elsif !user.activated?
        errors.add(:base, 'Account not activated! Check your email to activate your account.')
      end
    end
    return nil
  end

  def remember?
    return true if remember.to_i == 1
    return false
  end

  def persisted?
    return false
  end
end