class EmailsController < ApplicationController
  before_filter :ensure_contact

  def index
    @emails = @contact.emails
  end
  
  def new
    @email = @contact.emails.build
  end

  def create
    @email = @contact.emails.build(params[:email])
    if @email.save
      redirect_to contact_path(@contact), notice: "Successfully created email"
    else
      render :new
    end
  end

  def show
    @email = @contact.emails.select{|email| email.id.to_s == params[:id]}.first
  end

  def edit
    @email = @contact.emails.select{|email| email.id.to_s == params[:id]}.first
  end

  def update
    @email = @contact.emails.select{|email| email.id.to_s == params[:id]}.first
    if @email.update_attributes(params[:email])
      redirect_to(contact_path(@contact), notice: 'Email was successfully updated.')
    else
      render action: :edit
    end
  end

  def destroy
    @email = @contact.emails.select{|email| email.id.to_s == params[:id]}.first
    @email.destroy
    redirect_to(contact_path(@contact), notice: 'Email was successfully removed')
  end
private
  def ensure_contact
    @contact = @current_user.contacts.select{|contact| contact.id.to_s == params[:contact_id]}.first
    unless @contact
      redirect_to account_path, :notice => "It appears that the contact you entered does not exist"
    end
  end
end
