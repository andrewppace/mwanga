class SessionsController < ApplicationController
  layout "basic", only: [:new]
  def new
    @user = User.new(params[:user])
    if params[:user]
      if params[:user][:username] && params[:user][:password]
        user = User.authenticate(params[:user][:username], params[:user][:password])
        if user
          session[:user_id] = user.id
          if session[:redirect]
            redirect = session[:redirect]
            session[:redirect] = nil
            redirect_to redirect, flash: {success: "Logged in successfully"}
          else
            redirect_to account_path, flash: {success: "Logged in successfully"}
          end          
        else
          flash.now[:error] = "We're sorry, but the username and password you provided don't match our records"
          render :new         
        end
      else
        flash.now[:error] = "We're sorry, but the username and password you provided don't match our records"
        render :new      
      end
    end
  end

  def destroy
    session[:user_id] = nil
    session[:redirect] = nil
    redirect_to login_path, flash: {success: "Logged out successfully"}
  end
end
