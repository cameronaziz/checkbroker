class Advisor < ActiveRecord::Base
  has_many :organizations, through: :organization_advisors
  has_many :organization_advisors
  has_many :users, through: :user_advisors
  accepts_nested_attributes_for :users
  has_many :user_advisors

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :phone, presence: true
  validates :email, presence: true
  validates :address1, presence: true
  validates :city, presence: true
  validates :state, presence: true
  validates :zip, presence: true

  def full_name
    "#{first_name} #{last_name}"
  end

  def formatted_phone
    "(#{phone[0...3]}) #{phone[3...6]}-#{phone[6...10]}"
  end

end
