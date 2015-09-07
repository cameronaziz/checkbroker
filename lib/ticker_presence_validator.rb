class TickerPresenceValidator < ActiveModel::EachValidator
  def validate_each(object, attribute, value)
    data =  MutualFundWarehouse.pluck(:ticker)
    unless data.include? value
      object.errors[attribute] << (options[:message] || "#{value} can not be found")
    end
  end
end