class AccountsController < ApplicationController
  before_filter :require_user, :except => [:new, :create, :beta]
  before_filter :require_beta_key, :only => [:create, :new]
  before_filter :require_not_logged_in, :only => [:beta, :create, :new]
  
  def beta
    @user = User.new
    if request.post?
      if params[:beta_key] == BETA_KEY
        session[:beta_key] = BETA_KEY
        render :action => :new
      else
        @user.errors.add_to_base('Invalid beta key')
        render :action => :beta
      end
    end
  end
  
  def new
    @user = User.new
  end
  
  def create
    authenticate_with_open_id(params[:openid_identifier], { :optional => [:email, :nickname, :fullname] }) do |result, identity_url, profile|
      @user = User.find_or_create_by_identity_url(:identity_url => identity_url)
      if result.successful?
        if @user.save
          session[:user_id] = @user.id
          flash[:notice] = 'Successfully created account!'
          redirect_back_or_default(root_url)
        else
          render :action => :new
        end
      else
        if !result.message.blank?
          @user.errors.add_to_base(result.message)
        else
          @user.errors.add_to_base('There was an uknown problem authenticating with your OpenID provider')
        end
        render :action => :new
      end
    end
  end
    
  def show
    @user = current_user
    render :action => :edit
  end
  
  def update
    @user = current_user 
    @user.attributes = params[:user]
    if @user.save
      flash[:notice] = "Account updated!"
      redirect_to account_url
    else
      render :action => :edit
    end
  end

  protected

    def require_beta_key
      if !session.has_key?(:beta_key) && session[:beta_key] != BETA_KEY
        flash[:notice] = 'Beta key is required'
        redirect_to beta_url
        return false
      end
    end
end
