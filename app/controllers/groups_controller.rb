class GroupsController < ApplicationController
  before_action :set_group, only: [:edit, :update, :destroy]

  before_action do
    authenticate_user_and_group(%w(Administrators Managers), false)
  end

  def index
    @groups = Group.all
  end

  def new
    @group = Group.new
  end

  def create
    @group = Group.new(group_params)
    if @group.save
      redirect_to groups_path
    else
      render new_group_path
    end
  end



  def edit
  end

  def update
    if @group.update(group_params)
      redirect_to groups_path
    else
      render edit_group_path
    end
  end

  def destroy
    @group.destroy
    ##destroy relationship in Memberships
    redirect_to groups_path
  end

  private
  def set_group
    @group = Group.find(params[:id])
  end

  def group_params
    params.require(:group).permit(:name)
  end

end