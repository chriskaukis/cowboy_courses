class ApplicationController < ActionController::Base
  protect_from_forgery
  helper :all
  helper_method :current_user_session, :current_user, :logged_in?
  
  protected

    def current_user
      return @current_user if defined? @current_user
      @current_user = User.find_by_id(session[:user_id])
      return @current_user
    end
    
    def logged_in?
      return !current_user.nil?
    end
    
    def require_user
      unless logged_in?
        store_location
        flash[:notice] = "You must be logged in to access this page"
        redirect_to login_url
        return false
      end
    end
    
    def require_not_logged_in
      if logged_in?
        flash[:notice] = 'Um, what? No.'
        redirect_to root_url
        return false
      end
    end
    
    def store_location
      session[:return_to] = request.request_uri
    end
    
    def redirect_back_or_default(default)
      redirect_to(session[:return_to] || default)
      session[:return_to] = nil
    end
end
