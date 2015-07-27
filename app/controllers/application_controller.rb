class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def require_user
    unless current_user
      flash[:warning] = "Please sign in first."
      redirect_to sign_in_path
    end
  end

  def current_user
    User.find(session[:user_id]) if session[:user_id]
  end

  helper_method :current_user
end
