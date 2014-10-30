class Business < ActiveRecord::Base
  has_many :users
  has_many :items
  has_many :categories
end
