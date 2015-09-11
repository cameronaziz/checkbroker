class AdvisorsController < ApplicationController
  before_action :set_advisor, only: [:show, :destroy]

  before_action do
    auth_groups_redirect(['Administrators', 'Managers'])
  end

  def index
    @advisors = Advisor.all
  end

  def new
    @advisor = Advisor.new
    @advisor.is_verified = true
  end

  def create
    @advisor = Advisor.new(advisor_params)
    if @advisor.save
      user_advisor = UserAdvisor.new
      user_advisor.advisor_id = @advisor.id
      user_advisor.user_id = params[:user][:user_id]
      user_advisor.is_verified = true
      user_advisor.save
      organization_advisor = OrganizationAdvisor.new
      organization_advisor.advisor_id = @advisor.id
      organization_advisor.organization_id = params[:organization][:organization_id]
      organization_advisor.is_verified = true
      organization_advisor.save
      redirect_to advisors_path, notice: 'Investment Advisor was created.'
    else
      render 'advisors/new'
    end
  end

  def show

  end

  def destroy
    @advisor.destroy
    redirect_to advisors_path
  end

  private
  def set_advisor
    @advisor = Advisor.find(params[:id])
  end

  def advisor_params
    params.require(:advisor).permit(:first_name, :last_name, :image, :phone, :email, :address1, :address2, :city, :state, :zip, :is_verified)
  end
end