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
    require 'gruff'
    g = Gruff::Pie.new
    g.title = 'Percentages of Fees'
    mf_percent = @portfolio.management_fee / @portfolio.market_value
    g.data 'Management Fees', mf_percent
    of_percent = @portfolio.average_expense_ratio / @portfolio.market_value
    g.data 'Other Fees', of_percent
    file_name = 'public/images/pie_charts/portfolio_' + @portfolio.id.to_s + '.png'
    g.write(file_name)
  end


  def edit
    @investments = @portfolio.investments.build
  end

  def update
    nickname = @portfolio.nickname
    if @portfolio.update_attributes(portfolio_params)
      #! input email user fu
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
    params.require(:portfolio).permit(:nickname, :management_fee, investments_attributes: [:ticker, :quantity, '_destroy'])
  end

end
