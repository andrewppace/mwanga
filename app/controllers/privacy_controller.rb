class PrivacyController < ApplicationController
  before_filter :ensure_user
  def edit
    @user = @current_user
  end
  
  def update
    @user = @current_user
    @user.profiles.each do |profile|
      profile.emails = []
    end
    if params[:profiles]
      params[:profiles].each do |profile_id, profile_hash|
        profile = @user.profiles.select{|profile| profile.id.to_s == profile_id.to_s}.first
        if @user.profiles.map(&:id).map(&:to_s).include?(profile_id)
          profile_hash[:emails].each do |email_id, email_value|
            profile.emails << Email.find(email_id)
          end
        end
      end
    end
    redirect_to privacy_edit_path, notice: "Your privacy settings were saved"
  end
end
