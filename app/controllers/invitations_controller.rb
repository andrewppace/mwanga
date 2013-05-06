class InvitationsController < ApplicationController
  before_filter :ensure_user
  def index
    @invitations = @current_user.invitations
  end

  def create
    invitee = User.find_by_username(params[:invitation][:username])
    if invitee
      @relationship = Relationship.new
      @relationship.invitor = @current_user
      @relationship.invitee = invitee
      if @relationship.save
        redirect_to account_path, notice: "Your invitation is pending response"
      else
        redirect_to account_path, flash: {error: "We weren't able to create that connection"}
      end
    else
      redirect_to account_path, flash: {error: "We can't seem to find that person"}
    end
  end 
  
  def destroy
    @invitations = @current_user.invitations.select{|invitation| invitation.id.to_s == params[:id]}.first
    if @invitation.cancel!
      redirect_to account_path, notice: "Successfully cancelled invitation"
    else
      redirect_to account_path, flash: {error: "We weren't able to cancel that invitation"}
    end
  end 
end
