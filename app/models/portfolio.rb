class Portfolio < ActiveRecord::Base
  belongs_to :user
  has_many :investments
  accepts_nested_attributes_for :investments, :allow_destroy => true
  serialize :investments, Array
  attr_accessor :pie_data

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

  def average_12b1_fee
    if @average_12b1_fee
      return @average_12b1_fee
    end
    average_12b1_fee = 0
    self.investments.each do |investment|
      percent = investment.market_value / self.market_value
      portion = percent * investment.twelve_b_1
      average_12b1_fee = average_12b1_fee + portion
    end
    @average_12b1_fee = average_12b1_fee
  end

  def average_load_fee
    if @average_load_fee
      return @average_load_fee
    end
    average_load_fee = 0
    self.investments.each do |investment|
      percent = investment.market_value / self.market_value
      portion = percent * investment.load
      average_load_fee = average_load_fee + portion
    end
    @average_load_fee = average_load_fee
  end
end
