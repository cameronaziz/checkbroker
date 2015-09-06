class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :destroy, :update]

  before_action only: [:index, :new, :show, :create, :edit, :update, :destroy] do
    auth_group('Administrators')
  end

  skip_before_action :authenticate_user

  def index
    @users = User.all
  end

  def brokerage_registration
    @user = User.new
  end

  def brokerage_registration_create
    @user = User.new(user_with_brokerage_params)
    @user.brokerages.first.first_name = params[:user][:first_name]
    @user.brokerages.first.last_name = params[:user][:last_name]
    @user.brokerages.first.email = params[:user][:email]
    if @user.save
      redirect_to login_path, notice: 'Brokerage was saved.'
    else
      render 'users/brokerage_registration'
    end
  end


  def new
    @user = User.new
  end

  def register
    @user = User.new
  end

  def show
    @groups = @user.groups.all
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in(@user)
      redirect_to users_url, notice: "User was successfully created. Username: #{@user.username}"
    else
      render 'users/new'
    end
  end

  def create_register
    @user = User.new(register_params)
      if @user.save
        membership = Membership.new
        membership.group_id = '2'
        membership.user_id = @user.id
        membership.save
        render 'sessions/new'
      else
        render 'users/register'
      end
  end

  def edit
    @user_group = @user.memberships.build
  end

  def update
    if @user.update_attributes(user_params)
      #! input email user fu
      redirect_to users_url, notice: "The user \"#{username}\" was successfully updated."
    else
      render :edit
    end
  end

  def destroy
    deleted_username = @user.username
    @user.destroy
    redirect_to users_url, notice: "#{deleted_username} was successfully deleted."
  end

  private
  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation, {:group_ids => []})
  end

  def register_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation)
  end

  def user_with_brokerage_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation, :brokerages_attributes => [:id, :name, :about, :phone, :image, :address1, :address2, :city, :state, :zip])
  end

end