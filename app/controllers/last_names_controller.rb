class LastNamesController < ApplicationController
  before_filter :ensure_contact
  before_filter :add_breadcrumbs

  def index
    @last_names = @contact.last_names
  end
  
  def new
    @last_name = @contact.last_names.build
  end
  
  def create
    @last_name = @contact.last_names.build(params[:last_name])
    if @last_name.save
      redirect_to contact_last_name_path(@contact, @last_name), notice: "successfully created last name"
    else
      render :new
    end
  end
  
  def show
    @last_name = @contact.last_names.select{|last_name| last_name.id.to_s == params[:id]}.last
  end
  
  def edit
    @last_name = @contact.last_names.select{|last_name| last_name.id.to_s == params[:id]}.last
  end
  
  def update
    @last_name = @contact.last_names.select{|last_name| last_name.id.to_s == params[:id]}.last
    if @last_name.update_attributes(params[:last_name])
      redirect_to contact_last_name_path(@contact, @last_name), notice: "successfully updated last name"
    else
      render :edit
    end
  end
  
  def destroy
    @last_name = @contact.last_names.select{|last_name| last_name.id.to_s == params[:id]}.last
    @last_name.destroy
    redirect_to contact_last_names_path(@contact)
  end
private
  def add_breadcrumbs
    @breadcrumbs.add "my account", account_path
    @breadcrumbs.add "contacts", contacts_path
    @breadcrumbs.add "#{@contact.first_names.first.name} #{@contact.last_names.first.name}", contact_path(@contact)
  end
end
