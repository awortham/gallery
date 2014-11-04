class User < ActiveRecord::Base
  has_secure_password

  belongs_to :business

  has_many :orders
  has_many :addresses

  validates :name, presence: true
  validates_length_of :username, in: 2..32, allow_blank: true
  validates :username, allow_blank: true, length: { in: 2..32 }, uniqueness: {scope: :business_id}

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }, uniqueness: {scope: :business_id}

  def admin?
    admin == true
  end

  def display_name
    username.blank? ? format(name) : format(username)
  end

  def format(name)
    name.split.map {|n| n.strip.capitalize}.join(" ")
  end

  def active_orders
    orders.where(status: "ordered")
  end

  def paid_orders
    orders.where(status: "completed")
  end

  def cancelled_orders
    orders.where(status: "cancelled")
  end
end
