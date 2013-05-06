class ConfirmController < ApplicationController
  before_filter :check_already_confirmed, only: [:email]

  def email
    if @current_user.email_confirmation_salt == params[:email_confirmation_salt]
      @current_user.confirm!
      redirect_to account_path, notice: "Your email is successfully confirmed"
    else
      redirect_to account_path, flash: {error: "We could not verify your email"}
    end
  end
  
private
  def check_already_confirmed
    if @current_user.confirmed?
      redirect_to account_path, flash: {error: "Your email was already successfully confirmed"}
    end  
  end
end
