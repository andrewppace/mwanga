class RelationshipsController < ApplicationController
  before_filter :add_breadcrumbs
  def index
    @contacts = @current_user.connections
  end
  
  def requests
    @relationships = @current_user.requests
  end
  
  def create
    invitee = User.find_by_username(params[:relationship][:username])
    if invitee
      @relationship = Relationship.new
      @relationship.invitor = @current_user
      @relationship.invitee = invitee
      if @relationship.save
        redirect_to account_path, notice: "Your request is pending response"
      else
        redirect_to account_path, flash: {error: "We weren't able to create that connection"}
      end
    else
      redirect_to account_path, flash: {error: "We can't seem to find that person"}
    end
  end
  
  def confirm
    @relationship = Relationship.find(params[:id])
    if @current_user == @relationship.invitee
      @profile = @current_user.profiles.select{|profile| profile.id.to_s == params[:profile_id]}.first
      @relationship.profile = @profile
      @relationship.activate
    else
      redirect_to account_path, flash: {error: "You don't have permission to update that relationship"}
    end
  end
private
  def add_breadcrumbs
    @breadcrumbs.add "my account", account_path
    @breadcrumbs.add "#{@contact.first_names.first.name} #{@contact.last_names.first.name}", contact_path(@contact)
  end
end
