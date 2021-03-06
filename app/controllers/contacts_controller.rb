class ContactsController < ApplicationController
  before_filter :add_breadcrumbs
  layout "account"
  def index
    @contacts = @current_user.contacts
  end
    
  def new
    @contact = Contact.new
  end
    
  def create
    @contact = Contact.new(params[:contact])
    @contact.user = @current_user
    if @contact.save
      redirect_to @contact, notice: "successfully created contact"
    else
      render "new"
    end
  end
  
  def edit
    @contact = @current_user.contacts.select{|contact| contact.id.to_s == params[:id]}.first
  end
    
  def show
    @contact = @current_user.contacts.select{|contact| contact.id.to_s == params[:id]}.first
  end
  
  def myinfo
    @contact = @current_user.contact
    render "show"
  end
    
  def update
    @contact = @current_user.contacts.select{|contact| contact.id.to_s == params[:id]}.first
    if @contact.update_attributes(params[:contact])
      redirect_to @contact, notice: "successfully updated contact"
    else
      render "edit"
    end
  end
    
  def destroy
    @contact = @current_user.contacts.select{|contact| contact.id.to_s == params[:id]}.first
    @contact.destroy
    redirect_to contacts_path, notice: "successfully removed contact"
  end
private
  def add_breadcrumbs
    @breadcrumbs.add "my account", account_path
    @breadcrumbs.add "contacts", contacts_path
  end
end
