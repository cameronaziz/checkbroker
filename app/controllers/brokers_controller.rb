class BrokersController < ApplicationController
  before_action :set_broker, only: [:show, :edit, :destroy, :update]

  def index
    @brokers = Broker.all
  end

  def show

  end

  def new
    @broker = Broker.new
  end

  def create
    @broker = Broker.new(broker_params)
    clean_phone
    if @broker.save
      redirect_to brokers_path, notice: 'Broker was saved.'
    else
      render 'brokers/new'
    end
  end

  def edit

  end

  def update
    if @broker.update_attributes(broker_params)
      broker_name = @broker.full_name
      redirect_to brokers_path, notice: "The broker \"#{broker_name}\" was successfully updated."
    else
      render :edit
    end
  end

  def destroy
    deleted_broker = @broker.full_name
    @broker.destroy
    redirect_to brokers_path, notice: "#{deleted_broker} was successfully deleted."
  end

  private
  def set_broker
    @broker = Broker.find(params[:id])
  end

  def broker_params
    params.require(:broker).permit(:first_name, :last_name, :about, :email, :phone, :image)
  end

  def clean_phone
    @broker.phone = @broker.phone.gsub(/[^0-9a-z]/i, '')
  end
end
