class Investment < ActiveRecord::Base
  belongs_to :portfolio

  def expense_ratio
    record = MutualFund.find_by_ticker(self.ticker)
    if record.expense_ratio == nil || record.updated_at < (Time.now - (24*60*60))
      query_nav(record)
      url = 'http://fundfundamentals.xignite.com/xfundfundamentals.xml/GetFundExpenseRatios?IdentifierType=Symbol&Identifier=' + self.ticker.downcase + '&UpdatedSince=7/1/2012&_TOKEN=' + XIGNITE_TOKEN
      require 'open-uri'
      doc = Nokogiri::XML(open(url))
      er_value = doc.css('ProspectusNetExpenseRatio').first.content.to_f
      record.expense_ratio = er_value
      record.save
      er_value
    else
      record.expense_ratio
    end
  end

  def query_nav(record)
    url = 'http://navs.xignite.com/v2/xNAVs.xml/GetNAV?IdentifierType=Symbol&Identifier=' + self.ticker + '&_TOKEN=' + XIGNITE_TOKEN
    require 'open-uri'
    doc = Nokogiri::XML(open(url))
    nav_value = doc.css('NAV').first.content.to_f
    record.nav = nav_value
    record.save
    nav_value
  end

  def nav
    record = MutualFund.find_by_ticker(self.ticker)
    if record.nav == nil || record.updated_at < (Time.now - (15*60))
      query_nav record
    else
      record.nav
    end
  end

  def market_value
    self.quantity * self.nav
  end

end
