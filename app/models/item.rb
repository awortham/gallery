class Item < ActiveRecord::Base
  belongs_to :business
  belongs_to :image

  has_many :item_categories, dependent: :destroy
  has_many :categories, through: :item_categories
  has_many :order_items
  has_many :orders, through: :order_items

  # has_attached_file :image, :styles => { :large => "600x600", :medium => "300x300>", :thumb => "100x100>" }, :default_url => "http://fillmurray.com/252/158"
  # validates_attachment_content_type :image, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]

  validates :categories, presence: true

  validates :title, :description, presence: true, uniqueness: true
  validates :price, numericality: {greater_than_or_equal_to: 0.01}
  validates :status, inclusion: { in: ['active', 'retired'] }

  def available?
    status == "active"
  end

end
