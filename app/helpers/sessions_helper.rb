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
end