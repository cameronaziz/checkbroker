class Brokerage < ActiveRecord::Base
  mount_uploader :image, BrokerImageUploader
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :phone, length: { is: 10 }
  validates :email, presence: true, length: {maximum: 20}
  validates :about, length: {maximum: 250}
  attr_accessor :views


  before_create :clean_phone
  before_update :clean_phone

  has_many :users, through: :brokers
  has_many :brokers
  accepts_nested_attributes_for :users

  def all_approved
    Brokerage.where(is_verified: true)
  end

  def formatted_phone
    "(#{self.phone[0...3]}) #{self.phone[3...6]}-#{self.phone[6...10]}"
  end

  def shortened_name
    "#{first_name.capitalize} #{last_name[0...1].capitalize}."
  end

  def full_name
    "#{first_name} #{last_name}"
  end

  def views
    return @views if @views
    @views = AdView.where(broker_id: self.id)
  end

  def clean_phone
    self.phone = self.phone.gsub(/[^0-9a-z]/i, '')
  end
end
