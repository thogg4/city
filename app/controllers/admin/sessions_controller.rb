class Admin::SessionsController < ApplicationController
  def new
    if current_user
      redirect_to admin_user_path(current_user)
    end
  end
  def create
    user = User.find_by_email(params[:email])
    logger.debug user.inspect
    if user && user.authenticate(params[:password])
      logger.debug "log in worked"
      session[:user_id] = user.id
      redirect_to admin_user_path(user), :notice => "Logged in"
    else
      redirect_to admin_login_path
      flash[:error] = "Not logged in"
    end
  end
  def destroy
    session[:user_id] = nil
    redirect_to admin_login_path, :notice => "Logged out"
  end
end
