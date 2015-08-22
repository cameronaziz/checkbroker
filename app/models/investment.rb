class Investment < ActiveRecord::Base
  belongs_to :portfolio

  def expense_ratio
    record = MutualFund.find_by_ticker(self.ticker)
    if record
      if record.expense_ratio == nil || record.updated_at < (Time.now - (24*60*60))
        query_nav false, record
        query_er false, record
      else
        record.expense_ratio
      end
    else
      query_er true
    end
  end

  def nav
    record = MutualFund.find_by_ticker(self.ticker)
    if record
      if record.nav == nil || record.updated_at < (Time.now - (15*60))
        query_nav false, record
      else
        record.nav
      end
    else
      query_nav true
    end
  end

  def market_value
    self.quantity * self.nav
  end


private
  def query_nav(new_record, record = nil)
    url = 'http://navs.xignite.com/v2/xNAVs.xml/GetNAV?IdentifierType=Symbol&Identifier=' + self.ticker + '&_TOKEN=' + XIGNITE_TOKEN
    require 'open-uri'
    doc = Nokogiri::XML(open(url))
    nav_value = doc.css('NAV').first.content.to_f
    if new_record
      record = MutualFund.new
      record.ticker = self.ticker
    end
    record.nav = nav_value
    record.save
    nav_value
  end

  def query_er(new_record, record = nil)
    url = 'http://fundfundamentals.xignite.com/xfundfundamentals.xml/GetFundExpenseRatios?IdentifierType=Symbol&Identifier=' + self.ticker.downcase + '&UpdatedSince=7/1/2012&_TOKEN=' + XIGNITE_TOKEN
    require 'open-uri'
    doc = Nokogiri::XML(open(url))
    er_value = doc.css('ProspectusNetExpenseRatio').first.content.to_f
    if new_record
      record = MutualFund.new
      record.ticker = self.ticker
    end
    record.expense_ratio = er_value
    record.save
    er_value
  end
end
