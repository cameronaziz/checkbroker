class PortfoliosController < ApplicationController
  before_action :set_portfolio, only: [:show, :edit, :destroy, :update]
  include BrokersHelper


  def new
    @portfolio = Portfolio.new
    @investments = @portfolio.investments.build
  end

  def edit

  end


  def create
    @portfolio = Portfolio.new(portfolio_params)
    @portfolio.user_id = session[:user_id]
    if @portfolio.save
      redirect_to portfolios_path, notice: 'Portfolio was saved.'
    else
      render 'portfolios/new'
    end
  end

  def index
    if auth_group('Administrators')
      @portfolios = Portfolio.all
    else
      @portfolios = Portfolio.where(:user_id => session[:user_id])
    end
  end

  def show
    unless @portfolio.user_id == session[:user_id] || auth_group('Administrators')
      redirect_to portfolios_path, notice: 'Access to this portfolio is denied.'
    end
    @investments = Investment.where(:portfolio => @portfolio.id)

    #todo: round values

    pie_data = [ ['Broker Fees', @portfolio.management_fee ],
                 ['Expense Fees', @portfolio.average_expense_ratio],
                 ['Load Fees', @portfolio.average_load_fee],
                 ['12B-1 Fees', @portfolio.average_12b1_fee]
    ]
    @portfolio.pie_data = pie_data

    @broker = broker_ad
  end


  def edit_old
    @investments = @portfolio.investments.build
    @users = User.all
  end

  def update
    nickname = @portfolio.nickname
    if @portfolio.update_attributes(portfolio_params)
      redirect_to portfolios_path, notice: "The portfolio \"#{nickname}\" was successfully updated."
    else
      render :edit
    end
  end

  def destroy
    deleted_portfolio = @portfolio.nickname
    @portfolio.destroy
    redirect_to portfolios_url, notice: "#{deleted_portfolio} was successfully deleted."
  end

private
  def set_portfolio
    @portfolio = Portfolio.find(params[:id])
  end

  def portfolio_params
    params.require(:portfolio).permit(:nickname, :management_fee, investments_attributes: [:id, :ticker, :quantity, :_destroy])
  end

end
