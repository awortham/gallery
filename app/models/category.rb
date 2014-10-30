class Category < ActiveRecord::Base
  belongs_to :business

  has_many  :items, through: :item_categories
  has_many  :item_categories
end
