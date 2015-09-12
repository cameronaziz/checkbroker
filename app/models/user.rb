class User < ActiveRecord::Base
  has_many :memberships
  has_many :groups, through: :memberships
  has_many :portfolios
  has_many :brokerages, through: :brokers
  has_many :brokers
  accepts_nested_attributes_for :brokerages, allow_destroy: true
  validates :terms_of_service, :acceptance => true

  has_many :organizations, through: :organization_admins
  has_many :organization_admins
  has_many :advisors, through: :user_advisors
  has_many :advisor_admins

  attr_accessor :remember_token
  before_save {self.email = email.downcase}
  validates :first_name, presence: true, length: {maximum: 50}
  validates :last_name, presence: true, length: {maximum: 50}
  validates :email, presence: true, length: {maximum: 255}, #todo: add email validation
            uniqueness: {case_sensitive: false}
  has_secure_password
  validates :password, length: {minimum: 6}, allow_blank: true

  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
        BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  def User.new_token
    SecureRandom.urlsafe_base64
  end

  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  def authenticated?(remember_token)
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end

  def forget
    update_attribute(:remember_digest, nil)
  end

  def full_name
    "#{first_name} #{last_name}"
  end

end
