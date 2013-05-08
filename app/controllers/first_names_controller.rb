class FirstNamesController < ApplicationController
  before_filter :ensure_contact
  before_filter :add_breadcrumbs

  def index
    @first_names = @contact.first_names
  end
  
  def new
    @first_name = @contact.first_names.build
  end
  
  def create
    @first_name = @contact.first_names.build(params[:first_name])
    if @first_name.save
      redirect_to contact_first_name_path(@contact, @first_name), notice: "successfully created first name"
    else
      render :new
    end
  end
  
  def show
    @first_name = @contact.first_names.select{|first_name| first_name.id.to_s == params[:id]}.first
  end
  
  def edit
    @first_name = @contact.first_names.select{|first_name| first_name.id.to_s == params[:id]}.first
  end
  
  def update
    @first_name = @contact.first_names.select{|first_name| first_name.id.to_s == params[:id]}.first
    if @first_name.update_attributes(params[:first_name])
      redirect_to contact_first_name_path(@contact, @first_name), notice: "successfully updated first name"
    else
      render :edit
    end
  end
  
  def destroy
    @first_name = @contact.first_names.select{|first_name| first_name.id.to_s == params[:id]}.first
    @first_name.destroy
    redirect_to contact_first_names_path(@contact)
  end
private
  def add_breadcrumbs
    @breadcrumbs.add "my account", account_path
    @breadcrumbs.add "contacts", contacts_path
    @breadcrumbs.add "#{@contact.first_names.first.name} #{@contact.last_names.first.name}", contact_path(@contact)
  end
end
