class Home < ActiveRecord::Base
  belongs_to :business
  has_many :images, as: :imageable 
end
