class PasswordResetsController < ApplicationController
  def new
    @password_reset_request = PasswordResetRequest.new
  end

  def create
    @password_reset_request = PasswordResetRequest.new(params.required(:password_reset_request).permit(:email))
    if @password_reset_request.send_password_reset
      flash['success'] = 'Password reset request sent.'
      redirect_to root_url
    else
      render :new
    end
  end

  def edit
    @password_reset_token = params[:id]
    @user = User.find_by(email: params[:email])
    if @user.nil? || !@user.activated? || !@user.is_valid_password_reset_token?(@password_reset_token)
      flash[:danger] = 'Invalid password reset request.'
      redirect_to new_password_reset_url
    end
  end

  def update
    @password_reset_token = params[:id]
    email = params[:user][:email]
    password = params[:user][:password]
    @user = User.find_by(email: email)
    if @user.nil? || !@user.activated? || !@user.is_valid_password_reset_token?(@password_reset_token)
      flash[:danger] = 'Invalid password reset request'
      redirect_to root_url
    elsif @user.update_attribute(:password, password)
        flash[:success] = 'Password has been reset.'
        log_in(@user)
        remember(@user)
        redirect_to root_url
    else
      render :edit
    end
  end
end
