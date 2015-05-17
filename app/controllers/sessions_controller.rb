class SessionsController < ApplicationController
  def new
    @session = Session.new(params[:return_url])
  end

  def create
    @session = Session.new(params.require(:session).permit(:email, :password, :return_url, :remember))
    if user = @session.authenticate!
      log_in(user)
      @session.remember? ? remember(user) : forget(user)
      flash[:success] = "Welcome #{user.name}!"
      redirect_to @session.return_url || root_url
    else
      render :new
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to params[:return_url] || root_url
  end
end
