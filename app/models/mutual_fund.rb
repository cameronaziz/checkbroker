class MutualFund < ActiveRecord::Base

  def self.update_fund(ticker)
    record = MutualFund.find_by_ticker(ticker)
    record.nav = self.nav_yahoo_api(ticker)
    if API_LIVE
      record.expense_ratio = self.er_yahoo_api
      record.twelve_b_1 = self.twelve_b_1_yahoo_api
      record.load = self.load_yahoo_api
    else
      warehouse_data = MutualFundWarehouse.find_by_ticker(ticker)
      record.expense_ratio = warehouse_data.expense_ratio
      record.twelve_b_1 = warehouse_data.twelve_b_1
      record.load = warehouse_data.back_load + warehouse_data.front_load
    end
    record.auto_updated = Time.now
    record.save
  end


  def self.nav_yahoo_api(ticker)
    if NO_INTERNET
      99.69
    else
      nav_url = 'https://query.yahooapis.com/v1/public/yql?q=select%20*%20from%20yahoo.finance.quotes%20where%20symbol%20in%20(%22' + ticker + '%22)%0A%09%09&diagnostics=true&env=http%3A%2F%2Fdatatables.org%2Falltables.env'
      print nav_url
      nav_doc = Nokogiri::XML(open(nav_url))
      nav_doc.css('LastTradePriceOnly').first.content.to_f
    end
  end



end
