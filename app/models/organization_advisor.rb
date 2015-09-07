class OrganizationAdvisor < ActiveRecord::Base
  has_one :advisor
  has_one :organization
end