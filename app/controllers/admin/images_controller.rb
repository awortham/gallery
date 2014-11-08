class Admin::ImagesController < ApplicationController
  def new
    @image = @business.images.new
  end

  def create
    @image = @business.images.new(image_params)
    if @image.save
      redirect_to admin_dashboard_index_path(business.slug)
    else
      gflash :now,  :error => "Image was not added. Please try again."
      render :new
    end
  end

  private

  def image_params
    params.require(:image).permit(:name, :image)
  end
end
