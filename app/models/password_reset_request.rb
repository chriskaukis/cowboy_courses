class PasswordResetRequest
  include ActiveModel::Model

  attr_accessor :email

  validates :email, presence: true

  def send_password_reset
    if valid?
      user = User.find_by(email: email)
      if user.nil?
        errors.add(:base, 'No user found with that email.')
      elsif !user.activated?
        errors.add(:base, 'Account not active. Check your email to activate your account.')
      elsif user.create_password_reset_digest
        UserMailer.password_reset(user).deliver_now
        return true
      else
        errors.add(:base, 'There was an error trying to handle your password reset request.')
      end
    end
    return false
  end
end
