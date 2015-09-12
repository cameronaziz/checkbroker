class Organization < ActiveRecord::Base
  has_many :organization_admins
  has_many :users, through: :organization_admins

  has_many :organization_advisors
  has_many :advisors, through: :organization_advisors
  accepts_nested_attributes_for :organization_advisors, allow_destroy: true

  def formatted_phone
    "(#{phone[0...3]}) #{phone[3...6]}-#{phone[6...10]}"
  end

end
