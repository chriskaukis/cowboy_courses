class SessionsController < ApplicationController
  before_filter :require_user, :except => [:create, :new]
  before_filter :require_not_logged_in, :only => [:create, :new]
  
  def new
    @user = User.new
  end
  
  def create
    authenticate_with_open_id do |result, identity_url|
      if result.successful?
        if @user = User.find_or_create_by_identity_url(identity_url)
          session[:user_id] = @user.id
          flash[:notice] = 'Successfully logged in!'
          redirect_back_or_default(root_url)
        else
          @user = User.new
          @user.errors.add_to_base('We were unable to locate your account, perhaps you need to create one first')
          render :action => :new
        end
      else
        @user = User.new
        if !result.message.blank?
          @user.errors.add_to_base(result.message)
        else
          @user.errors.add_to_base('There was an uknown problem authenticating with the OpenID URL')
        end
        render :action => :new
      end # authenticate_with_open_id
    end
  end
  
  def destroy
    reset_session
    flash[:notice] = 'logged out'
    redirect_to login_url
  end
end
