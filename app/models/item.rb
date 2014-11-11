class Item < ActiveRecord::Base
  belongs_to :business
  belongs_to :image

  has_many :item_categories, dependent: :destroy
  has_many :categories, through: :item_categories
  has_many :order_items
  has_many :orders, through: :order_items

  validates :categories, presence: true

  validates :title, :description, presence: true
  validates :price, numericality: {greater_than_or_equal_to: 0.01}
  validates :status, inclusion: { in: ['active', 'retired'] }

  def available?
    status == "active"
  end

end
