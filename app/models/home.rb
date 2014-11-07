class Home < ActiveRecord::Base
  belongs_to :business
  has_many :images, as: :imageable
  accepts_nested_attributes_for :images 
end
