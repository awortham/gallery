class Admin::HomeImagesController < ApplicationController
  def new
    @home_image = business.home.home_images.new
  end

  def create
    @home_image = business.home.home_images.new(home_image_params)
    if @home_image.save
      redirect_to root_path
    else
      raise "HELL"
    end
  end

  private

  def home_image_params
    params.require(:home_image).permit(:image_id, :caption, :tagline)
  end
end
