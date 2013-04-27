class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :current_user

  def current_user
    @current_user ||= User.find_by_id(session[:user_id]) if session[:user_id]
  end
  
  def ensure_user
    unless @current_user
      session[:redirect] = request.fullpath
      redirect_to login_path, :notice => "You must be logged in to visit that page"
    end
  end
  
  def exclude_user
    if @current_user
      redirect_to account_path
    end
  end
end
