module SessionsHelper
  def log_in(user)
    session[:user_id] = user.id
  end

  def remember(user)
    user.remember!
    cookies.permanent.signed[:user_id] = user.id
    cookies.permanent.signed[:remember_token] = user.remember_token
  end

  def current_user
    return @current_user if defined?(@current_user)
    if session.has_key?(:user_id)
      user_id = session[:user_id]
      @current_user = User.find_by(id: user_id)
    elsif cookies.has_key?(:user_id)
      user_id = cookies.signed[:user_id]
      user = User.find_by(id: user_id)
      if !user.nil? && cookies.has_key?(:remember_token)
        remember_token = cookies.signed[:remember_token]
        if user.remembered?(remember_token)
          log_in(user)
          @current_user = user
        end
      end
    end
  end

  def logged_in?
    !current_user.nil?
  end

  def forget(user)
    user.forget!
    cookies.delete(:user_id)
    cookies.delete(:remember_token)
  end

  def log_out
    forget(current_user)
    session.delete(:user_id)
    @current_user = nil
  end

  def require_user
    unless logged_in?
      flash[:notice] = 'You must be logged in to access that page.'
      redirect_to login_url, return_url: request.original_url
      return false
    end
  end
  
  def require_not_logged_in
    if logged_in?
      flash[:notice] = 'You are already logged in.'
      redirect_to root_url
      return false
    end
  end
end
