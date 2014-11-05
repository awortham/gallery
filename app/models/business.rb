class Business < ActiveRecord::Base
  has_many :users
  has_many :items
  has_many :categories
  has_one  :home
  has_one  :about
end
