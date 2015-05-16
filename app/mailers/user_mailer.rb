class UserMailer < ApplicationMailer
  def account_activation(user)
    @user = user
    mail to: user.email, subject: 'Confirm Your Cowboy Courses Account'
  end

  def password_reset(user)
    @user = user
    mail to: user.email, subject: 'Cowboy Courses Password Reset Request'
  end
end
