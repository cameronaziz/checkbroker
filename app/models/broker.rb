class Broker < ActiveRecord::Base
  belongs_to :brokerage
  belongs_to :user
end
