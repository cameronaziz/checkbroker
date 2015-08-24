class Portfolio < ActiveRecord::Base
  belongs_to :user
  has_many :investments
  accepts_nested_attributes_for :investments, :allow_destroy => true
  serialize :investments, Array

  def market_value
    if @market_value
      return @market_value
    end
    total_value = 0
    investments = Investment.where(portfolio_id: self.id)
    investments.each do |investment|
      total_value = total_value + investment.market_value
    end
    @market_value = total_value
  end

  def average_expense_ratio
    if @average_expense_ratio
      return @average_expense_ratio
    end
    average_expense_ratio = 0
    investments = Investment.where(portfolio_id: self.id)
    investments.each do |investment|
      percent = investment.market_value / self.market_value
      portion = percent * investment.expense_ratio
      average_expense_ratio = average_expense_ratio + portion
    end
    @average_expense_ratio = average_expense_ratio
  end
end
