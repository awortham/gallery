class About < ActiveRecord::Base
  belongs_to :business
  has_attached_file :image, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => "http://fillmurray.com/252/158"
end
