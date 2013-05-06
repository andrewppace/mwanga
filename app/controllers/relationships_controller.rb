class RelationshipsController < ApplicationController
  def index
    @contact = @current_user.connections
  end
  
  def create
    invitee = User.find_by_username(params[:username])
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
end
