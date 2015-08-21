class PortfoliosController < ApplicationController
  before_action :set_portfolio, only: [:show, :edit, :destroy, :update]


  def new
    @portfolio = Portfolio.new
    @investments = @portfolio.investments.build
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

  def update

  end

  def index
    @portfolios = Portfolio.where(:user_id => session[:user_id])
  end

  def show
    if @portfolio.user_id != session[:user_id]
      redirect_to portfolios_path, notice: 'Access to this portfolio is denied.'
    end
    @investments = Investment.where(:portfolio => @portfolio.id)
  end


  def edit

  end

  def destroy

  end

private
  def set_portfolio
    @portfolio = Portfolio.find(params[:id])
  end

  def portfolio_params
    params.require(:portfolio).permit(:nickname, :management_fee, investments_attributes: [:ticker, :quantity, '_destroy'])
  end

end
