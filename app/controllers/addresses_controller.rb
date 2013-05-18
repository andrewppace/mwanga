class AddressesController < ApplicationController
  before_filter :ensure_contact
  before_filter :add_breadcrumbs
  layout "account"
  def index
    @addresses = @contact.addresses
  end
  
  def new
    @address = @contact.addresses.build
  end

  def create
    @address = @contact.addresses.build(params[:address])
    if @address.save
      redirect_to contact_address_path(@contact, @address), notice: "successfully created address"
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
      redirect_to(contact_address_path(@contact, @address), notice: 'successfully updated address.')
    else
      render :edit
    end
  end

  def destroy
    @address = @contact.addresses.select{|address| address.id.to_s == params[:id]}.first
    @address.destroy
    redirect_to(contact_addresses_path(@contact), notice: 'address was successfully removed')
  end
private
  def add_breadcrumbs
    @breadcrumbs.add "my account", account_path
    @breadcrumbs.add "contacts", contacts_path
    @breadcrumbs.add "#{@contact.full_name}", contact_path(@contact)
    @breadcrumbs.add "addresses", contact_addresses_path(@contact)
  end
end
