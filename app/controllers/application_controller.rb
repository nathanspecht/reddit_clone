class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def current_user
    User.
  end

  def login(user)
    session[:session_token] = user.reset_session_token
  end

  def logout(user)
  end

  def require_login!
  end


end
