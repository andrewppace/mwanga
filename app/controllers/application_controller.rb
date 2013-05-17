class ApplicationController < ActionController::Base
  before_filter :authorize
  before_filter :create_breadcrumbs

  def current_user
    @current_user ||= User.find_by_id(session[:user_id]) if session[:user_id]
  end

  def ensure_contact
    @contact = @current_user.contacts.select{|contact| contact.id.to_s == params[:contact_id]}.first
    unless @contact
      redirect_to account_path, :notice => "It appears that the contact you entered does not exist"
    end
  end
  
  def create_breadcrumbs
    @breadcrumbs = Breadcrumbs.new
    @breadcrumbs.add("home", root_path)
  end
  
  def authorize
    @current_permission ||= Permission.new(current_user, request)
    if !@current_permission.allow?
      if current_user
        redirect_to account_path, alert: "Not authorized"
      else
        session[:redirect] = request.fullpath
        redirect_to login_path, notice: "You must be logged in to visit that page"
      end
    end
  end
end
