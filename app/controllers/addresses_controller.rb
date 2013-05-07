class AddressesController < ApplicationController
  before_filter :ensure_contact
  add_breadcrumb "my account", account_path

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
end
