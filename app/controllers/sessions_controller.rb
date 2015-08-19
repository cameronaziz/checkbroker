class SessionsController < ApplicationController
  skip_before_action :authenticate_user

  def new
  end

  def create
    user = User.find_by_username(params[:session][:username].downcase)
    if user && user.authenticate(params[:session][:password])
      log_in user
      if params[:session][:remember_me] == '1'
        remember(user)
      end
      redirect_back_or root_path
    else
      flash[:alert] = 'Incorrect username or password.'
      redirect_to login_path
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to login_path
  end
end