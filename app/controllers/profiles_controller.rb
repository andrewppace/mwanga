class ProfilesController < ApplicationController
  before_filter :add_breadcrumbs
  layout "account"
  def index
    @profiles = @current_user.profiles
  end
    
  def new
    @profile = @current_user.profiles.build
  end
    
  def create
    @profile = Profile.new(params[:profile])
    @profile.user_id = @current_user.id
    if @profile.save
      redirect_to privacy_edit_path, notice: "Successfully created profile"
    else
      render :new
    end
  end
  
  def show
    @profile = @current_user.profiles.select{|profile| profile.id.to_s == params[:id].to_s}.first  
  end
    
  def edit
    @profile = @current_user.profiles.select{|profile| profile.id.to_s == params[:id].to_s}.first
  end
    
  def update
    @profile = @current_user.profiles.select{|profile| profile.id.to_s == params[:id].to_s}.first
    if @profile.update_attributes(params[:profile])
      redirect_to profiles_path, notice: "successfully updated profile"
    else
      render :edit
    end
  end
  
  def destroy
    @profile = @current_user.profiles.select{|profile| profile.id.to_s == params[:id]}.first
    @profile.destroy
    redirect_to account_path, notice: "Profile successfully destroyed"
  end
private
  def add_breadcrumbs
    @breadcrumbs.add "my account", account_path
    @breadcrumbs.add "profiles", profiles_path
  end
end
