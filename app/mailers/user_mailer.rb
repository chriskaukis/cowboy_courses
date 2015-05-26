class UserMailer < ApplicationMailer
  def account_activation(user)
    @user = user
    mail to: user.email, subject: 'Confirm Your Cowboy Courses Account'
  end

  def password_reset(user)
    @user = user
    mail to: user.email, subject: 'Cowboy Courses Password Reset Request'
  end

  def section_status_changed(subscription)
    @user = subscription.user
    @section = subscription.section
    mail to: @user.email, subject: "#{@section.name} (Call #: #{@section.call_number}) Status Changed To: #{@section.status}"
  end
end
