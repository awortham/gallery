class Admin::ImagesController < ApplicationController
  def new
    @image = @business.images.new
  end

  def create
    @image = @business.images.new(image_params)
    if @image.save
      redirect_to admin_dashboard_path(@business)
    else
      raise "HELL"
    end
  end

  private

  def image_params
    params.require(:image).permit(:name, :image)
  end
end
