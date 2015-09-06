class StaticPagesController < ApplicationController

  skip_before_action :authenticate_user, only: [:index, :legal, :privacy]


  def index
    if logged_in?
      @user = User.find(session[:user_id])
    end
  end

  def help
  end

  def profile
    @user = User.find(session[:user_id])
  end

  def legal
  end

  def privacy
  end
end
