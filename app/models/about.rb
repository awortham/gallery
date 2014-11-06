class About < ActiveRecord::Base
  belongs_to :business
  has_one :image, as: :imageable
end