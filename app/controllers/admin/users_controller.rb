class Admin::UsersController < ApplicationController
  def new
    @user = User.new
  end
  def show
    @user = User.find(params[:id])
  end
  def create
    @user = User.new(params[:user])
    if @user.save
      session[:user_id] = @user.id
      redirect_to admin_user_path(@user), :notice => "User created"
    else
      redirect_to new_admin_user_path
      flash[:error] = "Something went wrong and the user was not created"
    end
  end
end
