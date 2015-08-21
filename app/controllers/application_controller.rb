class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  include SessionsHelper

  checkLogin = false
  unless  Rails.env.development? && checkLogin == false
    before_action :authenticate_user
  end

end
