class AdvisorsController < ApplicationController
  before_action :set_advisor, only: [:show, :destroy, :edit, :update]

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
      advisor_admin = AdvisorAdmin.new
      advisor_admin.advisor_id = @advisor.id
      advisor_admin.user_id = session[:user_id]
      advisor_admin.is_verified = true
      advisor_admin.save
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

  def edit
  end

  def update
    if @advisor.update_attributes(advisor_params)
      #! input email user fu
      redirect_to advisors_path, notice: "The user \"#{@advisor.full_name}\" was successfully updated."
    else
      render :edit
    end
  end

  def destroy
    deleted_advisor = @advisor.full_name
    if @advisor.destroy
      redirect_to advisors_path, notice: "#{deleted_advisor} was successfully deleted."
    end
  end

  private
  def set_advisor
    @advisor = Advisor.find(params[:id])
  end

  def advisor_params
    params.require(:advisor).permit(:first_name, :last_name, :image, :phone, :email, :address1, :address2, :city, :state, :zip, :is_verified)
  end
end