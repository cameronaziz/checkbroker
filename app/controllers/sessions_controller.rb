class SessionsController < ApplicationController
  skip_before_action :authenticate_user
  skip_before_filter :verify_authenticity_token, only: :destroy

  def new
  end

  def create
    user_input = params[:session][:username]
    if user_input.include? '@'
      user = User.find_by(email: params[:session][:username].downcase)
    else
      user = User.find_by(username: params[:session][:username].downcase)
    end
    if user && user.authenticate(params[:session][:password])
      log_in user
      if params[:session][:remember_me] == '1'
        remember(user)
      end
      redirect_back_or profile_path
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