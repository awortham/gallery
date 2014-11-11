class Admin::HomeImagesController < ApplicationController
  def new
    @home_image = business.home.home_images.new
  end

  def create
    @home_image = business.home.home_images.new(home_image_params)
    if @home_image.save
      redirect_to home_path(business.slug)
    else
      gflash :now,  :error => "Page was not updated. Please try again."
      render :new
    end
  end

  def edit
    @home_image = business.home.home_images.find(params[:id])
  end

  def update
    @home_image = business.home.home_images.find(params[:id])
    if @home_image.update(home_image_params)
      gflash :now, :success => "Image was successfully updated!"
      redirect_to admin_dashboard_index_path(business.slug)
    else
      gflash :now, :error => "Image was not updated. Please try again... Sucka"
      render :edit
    end
  end

  def destroy
    business.home.home_images.find(params[:id]).destroy
    gflash :now,  :success => "Category was successfully deleted."
    redirect_to admin_dashboard_index_path(business.slug)
  end

  private

  def home_image_params
    params.require(:home_image).permit(:image_id, :caption, :tagline)
  end
end
