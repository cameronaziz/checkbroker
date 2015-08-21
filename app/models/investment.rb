class Investment < ActiveRecord::Base
  belongs_to :portfolio

  def expense_ratio
    record = MutualFund.find_by_ticker(self.ticker)
    if record == nil || record.updated_at < (Time.now - (24*60*60))
      url = 'https://raw.githubusercontent.com/cameronaziz/xml/master/' + self.ticker + '.xml'
      require 'open-uri'
      doc = Nokogiri::XML(open(url))
      doc.css('ProspectusNetExpenseRatio').first.content
    else
      record.expense_ratio
    end
  end

  def nav
    record = MutualFund.find_by_ticker(self.ticker)
    if record == nil || record.updated_at < (Time.now - (15*60))
      #todo: call api
      100
    else
      record.nav
    end

  end

  def market_value
    self.quantity * nav
  end



end
