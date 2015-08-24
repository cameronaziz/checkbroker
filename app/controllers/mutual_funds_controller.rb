class MutualFundsController < ApplicationController
  before_action :set_mutual_fund, only: [:show, :edit, :destroy, :update]

  def index
    @mutual_funds = MutualFund.all
  end

  def new
    @mutual_fund = MutualFund.new
  end

  def create
    @mutual_fund = MutualFund.new(mutual_fund_params)
    if @mutual_fund.save
      redirect_to mutual_funds_path, notice: "Mutual fund \"#{@mutual_fund.ticker}\" was successfully created."
    else
      render mutual_fund_path
    end
  end

  def show
  end

  def edit
  end

  def update
    ticker = @mutual_fund.ticker
    if @mutual_fund.update_attributes(mutual_fund_params)
      redirect_to mutual_funds_url, notice: "\"#{ticker}\" was successfully updated."
    else
      render :edit
    end
  end

  def destroy
    fund = @mutual_fund.ticker.upcase
    @mutual_fund.destroy
    redirect_to mutual_funds_path, notice: "Mutual fund \"#{fund}\" was deleted."
  end


private
  def set_mutual_fund
    @mutual_fund = MutualFund.find(params[:id])
  end

  def mutual_fund_params
    params.require(:mutual_fund).permit(:ticker, :nav, :expense_ratio)
  end
end
