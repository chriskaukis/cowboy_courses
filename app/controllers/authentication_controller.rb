class AuthenticationController < ApplicationController

  def new
    @login = Login.new
  end

  def create
    @login = Login.new(params.require(:login).permit(:email, :password))
    if @login.valid? && @login.authenticate
      # TODO
    else
      render :new
    end
  end
end
