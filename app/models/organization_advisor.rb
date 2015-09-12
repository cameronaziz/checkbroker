class OrganizationAdvisor < ActiveRecord::Base
  belongs_to :advisor
  belongs_to :organization

  validates_uniqueness_of :advisor_id, scope: :organization_id
end