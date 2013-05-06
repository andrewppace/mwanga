class RequestsController < ApplicationController
  def index
    @requests = @current_user.requests
  end
  
  def update
    @relationship = Relationship.find(params[:id])
    if @current_user == @relationship.invitee
      @profile = @current_user.profiles.select{|profile| profile.id.to_s == params[:request][:profile_id]}.first
      @relationship.profile = @profile
      @relationship.activate!
      redirect_to account_path, notice: "Successfully connected"
    else
      redirect_to account_path, flash: {error: "You don't have permission to update that relationship"}
    end
  end
  
  def destroy
    @relationship = Relationship.find(params[:id])
    if @current_user == @relationship.invitee
      @relationship.reject!
      redirect_to account_path, notice: "Successfully rejected request"
    else
      redirect_to account_path, flash: {error: "You don't have permission to update that relationship"}
    end
  end
end
