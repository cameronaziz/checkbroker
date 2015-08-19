class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :destroy, :update]

  before_action do
    authenticate_user_and_group(['Administrators', 'Managers'], false)
  end

  def index
    @users = User.all
  end

  def new
    @user = User.new
    @all_groups = Group.all
    @user_group = @user.memberships.build
  end

  def show
    @groups = @user.groups.all
  end

  def create
    @user = User.new(user_params)
    create_username ## todo: fix so that it will error properly if username taken.
    if @user.save
      redirect_to users_url, notice: "User was successfully created. Username: #{@user.username}"
    else
      render 'users/new'
    end
  end

  def edit
    @user_group = @user.memberships.build
  end

  def update
    username = @user.username
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
    params.require(:user).permit(:username, :first_name, :last_name, :email, :password, :password_confirmation, {:group_ids => []})
  end

  def create_username
    first_name = @user.first_name.downcase
    last_name = @user.last_name.downcase
    @user.username = "#{first_name}.#{last_name}"
  end
end