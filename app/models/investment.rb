class Investment < ActiveRecord::Base
  require 'open-uri'

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
    return @market_value if @market_value
    @market_value = self.quantity * self.nav
  end

private
  def get_mutual_fund
    record = MutualFund.find_by_ticker(self.ticker)
    if record.nil?
      fund = MutualFund.new
      fund.ticker = self.ticker
      fund.nav = nav_yahoo_api
      fund.expense_ratio = er_yahoo_api
      fund.save
      record = fund
    else
      if record.updated_at < (Time.now - (24*60*60))
        record.nav = nav_yahoo_api
        record.expense_ratio = er_yahoo_api
        record.save
      else if record.updated_at < (Time.now - (15*60))
        record.nav = nav_yahoo_api
        record.save
           end
      end
    end
    record
  end

  def nav_yahoo_api
    nav_url = 'https://query.yahooapis.com/v1/public/yql?q=select%20*%20from%20yahoo.finance.quotes%20where%20symbol%20in%20(%22' + self.ticker + '%22)%0A%09%09&diagnostics=true&env=http%3A%2F%2Fdatatables.org%2Falltables.env'
    print nav_url
    nav_doc = Nokogiri::XML(open(nav_url))
    nav_doc.css('PreviousClose').first.content.to_f
  end

  def er_yahoo_api
    1
  end

  def nav_xignite_api
    nav_url = 'http://navs.xignite.com/v2/xNAVs.xml/GetNAV?IdentifierType=Symbol&Identifier=' + self.ticker + '&_TOKEN=' + XIGNITE_TOKEN
    print 'nav api query'
    nav_doc = Nokogiri::XML(open(nav_url))
    nav_doc.css('NAV').first.content.to_f
  end

  def er_xignite_api
    er_url = 'http://fundfundamentals.xignite.com/xfundfundamentals.xml/GetFundExpenseRatios?IdentifierType=Symbol&Identifier=' + self.ticker.downcase + '&UpdatedSince=7/1/2012&_TOKEN=' + XIGNITE_TOKEN
    print 'er api query'
    er_doc = Nokogiri::XML(open(er_url))
    er_doc.css('ProspectusNetExpenseRatio').first.content.to_f
  end

end