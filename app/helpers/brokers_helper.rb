module BrokersHelper

  def brokerage_ad
    brokerage = Brokerage.offset(rand(Brokerage.count)).first
    log_ad_view(brokerage.id)
    brokerage
  end

  private
  def log_ad_view(brokerage_id)
    unless auth_group('Administrators')
      view = AdView.new
      view.user_id = session[:user_id]
      view.brokerage_id = brokerage_id
      view.save
    end
  end
end
