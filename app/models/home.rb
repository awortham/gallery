class Home < ActiveRecord::Base
  belongs_to :business
  has_many :home_images

  def images
    home_images
  end
end
