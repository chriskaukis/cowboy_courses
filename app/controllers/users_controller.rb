class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(params.require(:user).permit(:name, :email, :password))
    if @user.save
      UserMailer.account_activation(@user).deliver_now
      flash['success'] = 'Thanks for signing up! Please check your email to activate your account.'
      redirect_to root_url
    else
      render :new
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def activate
    email = params.required(:email)
    token = params.required(:token)
    user = User.find_by(email: email)
    if !user.nil? && user.activate!(token)
      flash['success'] = 'Account activated!'
      log_in(user)
      remember(user)
      redirect_to root_url
    else
      flash['danger'] = 'Invalid activation token'
      redirect_to root_url
    end
  end
end
