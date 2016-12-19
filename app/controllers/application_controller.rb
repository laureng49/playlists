class ApplicationController < ActionController::Base
  def current_user
    User.find(session[:user_id]) if session[:user_id]
  end

  def require_login
    redirect_to '/index' if session[:user_id] == nil
  end

  def require_current_user
    u=User.find(session[:user_id])
		redirect_to "/users/#{current_user.id}" if current_user != u
  end


  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
end
