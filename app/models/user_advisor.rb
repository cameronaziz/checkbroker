class UserAdvisor < ActiveRecord::Base
  has_one :advisor
  has_one :user
end
