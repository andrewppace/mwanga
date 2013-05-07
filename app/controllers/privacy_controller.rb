class PrivacyController < ApplicationController
  before_filter :add_breadcrumbs
  def edit
    @user = @current_user
    if @user.profiles.empty?
      redirect_to account_path, notice: "You need to create a profile first"
    end
  end
  
  def update
    @user = @current_user
    @user.profiles.each do |profile|
      profile.emails = []
      profile.addresses = []
    end
    if params[:profiles]
      params[:profiles].each do |profile_id, profile_hash|
        profile = @user.profiles.select{|profile| profile.id.to_s == profile_id.to_s}.first
        if @user.profiles.map(&:id).map(&:to_s).include?(profile_id)
          profile_hash[:emails].each do |email_id, email_value|
            profile.emails << Email.find(email_id)
          end if profile_hash[:emails]
          profile_hash[:addresses].each do |address_id, address_value|
            profile.addresses << Address.find(address_id)
          end if profile_hash[:addresses]
        end
      end
    end
    redirect_to account_path, notice: "Your privacy settings were saved"
  end
private
  def add_breadcrumbs
    @breadcrumbs.add "my account", account_path
  end
end
