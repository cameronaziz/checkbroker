class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  include SessionsHelper

  check_login = false
  before_action :authenticate_user unless Rails.env.development? && check_login == false

end
