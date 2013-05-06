class ApplicationController < ActionController::Base
  before_filter :authorize
#  before_filter :current_user

  def current_user
    @current_user ||= User.find_by_id(session[:user_id]) if session[:user_id]
  end
  
#  def ensure_user
#    unless @current_user
#      session[:redirect] = request.fullpath
#      redirect_to login_path, :notice => "You must be logged in to visit that page"
#    end
#  end
  
#  def exclude_user
#    if @current_user
#      redirect_to account_path
#    end
#  end
  
  def authorize
    @current_permission ||= Permission.new(current_user, request)
    if !@current_permission.allow?
      if @current_permission.login_required?
        session[:redirect] = request.fullpath
        redirect_to login_path, notice: "You must be logged in to visit that page"
      else
        redirect_to root_path, alert: "Not authorized"
      end
    end
  end
end
