class BrokeragesController < ApplicationController
  before_action :set_broker, only: [:show, :edit, :destroy, :update, :raw]
  skip_before_action :authenticate_user, only: [:signup, :create_brokerage]


  def index
    @brokers = Brokerage.all
  end

  def signup
    @brokerage = Brokerage.new
  end

  def create_brokerage
    @brokerage = Brokerage.new(brokerage_params)
    @brokerage.first_name = params[:brokerage][:users_attributes]['0'][:first_name]
    @brokerage.last_name = params[:brokerage][:users_attributes]['0'][:last_name]
    @brokerage.email = params[:brokerage][:users_attributes]['0'][:email]
    @brokerage.is_verified = false
    clean_phone
    if @brokerage.save
      redirect_to login_path, notice: 'Broker was saved.'
    else
      render 'brokerages/signup'
    end
  end

  def show
  end

  def new
    @brokerage = Brokerage.new
  end

  def raw
  end

  def create
    @broker = Brokerage.new(brokerage_params)
    clean_phone
    if @broker.save
      redirect_to brokers_path, notice: 'Broker was saved.'
    else
      render 'brokerages/new'
    end
  end

  def edit
  end

  def update
    if @broker.update_attributes(broker_params)
      broker_name = @broker.full_name
      redirect_to broker_path, notice: "The broker \"#{broker_name}\" was successfully updated."
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

  def brokerage_params
    params.require(:brokerage).permit(:first_name, :last_name, :about, :email, :phone, :image, :users_attributes => [:id, :first_name, :last_name, :email, :password, :password_confirmation])
  end

  def clean_phone
    @brokerage.phone = @brokerage.phone.gsub(/[^0-9a-z]/i, '')
  end
end