class About < ActiveRecord::Base
  belongs_to :business
  has_one :image, as: :imageable
  accepts_nested_attributes_for :image
end
