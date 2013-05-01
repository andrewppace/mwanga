class ContactsController < ApplicationController
  before_filter :ensure_user
    
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
end
