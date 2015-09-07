class Organization < ActiveRecord::Base
  has_many :organization_admins
  has_many :users, through: :organization_admins
  has_many :organization_advisors
  has_many :advisors, through: :organization_advisors
end
