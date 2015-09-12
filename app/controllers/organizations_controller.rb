class OrganizationsController < ApplicationController
  before_action :set_organization, only: [:show, :destroy, :edit, :update, :add_advisors, :add_advisors_create]
  before_action :auth, except: [:show]

  def new
    @organization = Organization.new
    @organization.is_verified = true
  end

  def create
    @organization = Organization.new(organization_params)
    if @organization.save
      user_advisor = OrganizationAdmin.new
      user_advisor.organization_id = @organization.id
      user_advisor.user_id = session[:user_id]
      user_advisor.is_verified = true
      user_advisor.save
      redirect_to organizations_path, notice: 'Organization was created.'
    else
      render 'organizations/new'
    end
  end

  def add_advisors
    @organization.organization_advisors.build
    @organization.organization_advisors.each do |oa|
      oa.is_verified = true
    end
  end

  def add_advisors_create
    if @organization.update_attributes(organization_params)
      redirect_to organizations_path, notice: 'Advisor was added.'
    else
      render :add_advisors
    end
  end

  def approve_advisors
    organization_advisor = OrganizationAdvisor.where(:organization_id=>params[:id]).where(:advisor_id=>params[:advisors_id]).first
    organization_advisor.is_verified = true
    organization_advisor.save
    redirect_to organization_path(params[:id])
  end

  def remove_advisors
    organization_advisor = OrganizationAdvisor.where(:organization_id=>params[:id]).where(:advisor_id=>params[:advisors_id]).first
    organization_advisor.is_verified = false
    organization_advisor.save
    redirect_to organization_path(params[:id])
  end

  def edit
  end

  def update
    if @organization.update_attributes(organization_params)
      redirect_to organizations_path, notice: 'Organization was saved.'
    else
      render 'organizations/new'
    end
  end

  def show
  end

  def index
    @organizations = Organization.all
  end

  def destroy
    deleted_organization = @organization.name
    if @organization.destroy
      redirect_to organizations_path, notice: "#{deleted_organization} was successfully deleted."
    end
  end

  private
  def set_organization
    @organization = Organization.find(params[:id])
  end

  def organization_params
    params.require(:organization).permit(:id, :name, :image, :phone, :email, :address1, :address2, :city, :state, :zip, :is_verified, organization_advisors_attributes: [:id, :advisor_id, :is_verified, :_destroy])
  end

  def advisors_params
    params.require(:organization).permit(advisors_params[:id])
  end

  def auth
    auth_groups_redirect(['Administrators', 'Managers'])
  end

end
