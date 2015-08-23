class Investment < ActiveRecord::Base
  belongs_to :portfolio
  attr_accessor :nav
  attr_accessor :expense_ratio



  def nav
    return @nav if @nav
    record = get_mutual_fund
    @nav = record.nav
  end

  def expense_ratio
    return @expense_ratio if @expense_ratio
    record = get_mutual_fund
    @expense_ratio = record.expense_ratio
  end


  def market_value
    self.quantity * self.nav
  end

  private

  def get_mutual_fund
    record = MutualFund.find_by_ticker(self.ticker)
    if record.nil?
      fund = MutualFund.new
      fund.ticker = self.ticker
      fund.nav = nav_api
      fund.expense_ratio = er_api
      fund.save
      fund
    else
      date = record.updated_at
      if date < (Time.now - (24*60*60))
        record.nav = nav_api
        record.expense_ratio = er_api
        record.save
      else if date < (Time.now - (15*60))
        record.nav = nav_api
        record.save
           end
      end
      record
    end
  end

  def nav_api
    189
  end

  def er_api
    9
  end

end