class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      session[:user_id] = @user.id
      redirect_to account_path, notice: "Successfully created account"
    else
      render :new
    end
  end

  def show
    @user = @current_user
  end

  def edit
    @user = @current_user
  end

  def update
    @user = @current_user
    if @user.update_attributes(params[:user])
      redirect_to(account_path, notice: 'Account was successfully updated.')
    else
      render action: :edit
    end
  end

  def destroy
    @user = @current_user
    @user.deactivate!
    redirect_to(root_path, notice: 'Your account was successfully deactivated')
  end
end
