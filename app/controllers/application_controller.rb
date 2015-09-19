class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_user

  def current_user
    User.find_by_session_token(session[:session_token])
  end

  def login(user)
    session[:session_token] = user.reset_session_token
  end

  def logout(user)
    user.reset_session_token
    session[:session_token] = nil
  end

  def require_login!
    unless current_user
      flash[:errors] = ["Please log in"]
      redirect_to new_session_url
    end
  end

  def require_admin!
    subb = Sub.find(params[:id])
    mod_id = subb.moderator_id

    unless current_user.id == mod_id
      flash[:errors] =["This isn't your sub! Get out of here!"]
      redirect_to subs_url
    end
  end

end
