class HomeImage < ActiveRecord::Base
  belongs_to :home
  belongs_to :image

  def url
    image.url
  end
end
