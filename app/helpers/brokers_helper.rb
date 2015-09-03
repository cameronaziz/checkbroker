module BrokersHelper

  def broker_ad
    broker = Broker.offset(rand(Broker.count)).first
    log_ad_view(broker.id)
    broker
  end

  private
  def log_ad_view(broker_id)
    unless auth_group('Administrators')
      view = AdView.new
      view.user_id = session[:user_id]
      view.broker_id = broker_id
      view.save
    end
  end
end
