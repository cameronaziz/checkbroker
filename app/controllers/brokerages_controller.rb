class BrokeragesController < ApplicationController
  before_action :set_brokerage, only: [:show, :edit, :destroy, :update, :raw, :brokerage_verify]

  def index
    @brokerages = Brokerage.all
  end

  def show
  end

  def brokerage_verify
    @brokerage.is_verified = true
    @brokerage.save
    redirect_to brokerages_path
  end

  def new
    @brokerage = Brokerage.new
    @brokerage.is_verified = true
  end

  def raw
  end

  def create
    @brokerage = Brokerage.new(brokerage_params)
    broker_name = @brokerage.name
    if @brokerage.save
      redirect_to brokerages_path, notice: "Broker \"#{broker_name}\" was saved."
    else
      render 'brokerages/new'
    end
  end

  def edit
  end

  def update
    if @brokerage.update_attributes(broker_params)
      broker_name = @brokerage.name
      redirect_to brokerage_path, notice: "The broker \"#{broker_name}\" was successfully updated."
    else
      render :edit
    end
  end

  def destroy
    deleted_brokerage = @brokerage.name
    @brokerage.destroy
    redirect_to brokerages_path, notice: "#{deleted_brokerage} was successfully deleted."
  end

  private
  def set_brokerage
    @brokerage = Brokerage.find(params[:id])
  end

  def brokerage_params
    params.require(:brokerage).permit(:name, :first_name, :last_name, :about, :email, :phone, :image, :is_verified, :address1, :address2, :city, :state, :zip)
  end


end