class AddressesController < ApplicationController
  before_filter :ensure_contact

  def index
    @addresses = @contact.addresses
  end
  
  def new
    @address = @contact.addresses.build
  end

  def create
    @address = @contact.addresses.build(params[:address])
    if @address.save
      redirect_to contact_path(@contact), notice: "Successfully created address"
    else
      render :new
    end
  end

  def show
    @address = @contact.addresses.select{|address| address.id.to_s == params[:id]}.first
  end

  def edit
    @address = @contact.addresses.select{|address| address.id.to_s == params[:id]}.first
  end

  def update
    @address = @contact.addresses.select{|address| address.id.to_s == params[:id]}.first
    if @address.update_attributes(params[:address])
      redirect_to(contact_path(@contact), notice: 'address was successfully updated.')
    else
      render action: :edit
    end
  end

  def destroy
    @address = @contact.addresses.select{|address| address.id.to_s == params[:id]}.first
    @address.destroy
    redirect_to(contact_path(@contact), notice: 'address was successfully removed')
  end
private
  def ensure_contact
    @contact = @current_user.contacts.select{|contact| contact.id.to_s == params[:contact_id]}.first
    unless @contact
      redirect_to account_path, :notice => "It appears that the contact you entered does not exist"
    end
  end
end
