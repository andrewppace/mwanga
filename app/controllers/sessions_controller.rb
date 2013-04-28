class SessionsController < ApplicationController
  before_filter :exclude_user, except: [:destroy]
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
            redirect_to redirect, notice: "Logged in successfully"
          else
            redirect_to account_path, notice: "Logged in successfully"
          end          
        else
          @error = "Invalid username or password"
          render :new         
        end
      else
        @error = "Invalid username or password"
        render :new      
      end
    end
  end

  def create
  
  end
  def destroy
    session[:user_id] = nil
    redirect_to login_path, notice: "Logged out!"
  end
end
