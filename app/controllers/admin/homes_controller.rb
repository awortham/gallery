class Admin::HomesController < ApplicationController
  def edit
    @home = Home.find(params[:id])
  end

# {"image1"=>
#   {"image1"=>
#     #<ActionDispatch::Http::UploadedFile:0x007f9c62dd8f28
#      @content_type="image/png",
#      @headers="Content-Disposition: form-data; name=\"home[image1][image1]\"; filename=\"MountainTop Cafe-logo.png\"\r\nContent-Type: image/png\r\n",
#      @original_filename="MountainTop Cafe-logo.png",
#      @tempfile=#<File:/var/folders/45/c8b4jw614732cgddh_lrd52c0000gn/T/RackMultipart20141106-12038-2f73uc>>},
#  "image2"=>
#   {"image2"=>
#     #<ActionDispatch::Http::UploadedFile:0x007f9c62dda1c0
#      @content_type="image/png",
#      @headers="Content-Disposition: form-data; name=\"home[image2][image2]\"; filename=\"MountainTop Cafe-logo.png\"\r\nContent-Type: image/png\r\n",
#      @original_filename="MountainTop Cafe-logo.png",
#      @tempfile=#<File:/var/folders/45/c8b4jw614732cgddh_lrd52c0000gn/T/RackMultipart20141106-12038-1m0f95c>>},
#  "image3"=>
#   {"image3"=>
#     #<ActionDispatch::Http::UploadedFile:0x007f9c62de3388
#      @content_type="image/jpeg",
#      @headers="Content-Disposition: form-data; name=\"home[image3][image3]\"; filename=\"tumblr_static_cheese_205_1362800142.jpg\"\r\nContent-Type: image/jpeg\r\n",
#      @original_filename="tumblr_static_cheese_205_1362800142.jpg",
#      @tempfile=#<File:/var/folders/45/c8b4jw614732cgddh_lrd52c0000gn/T/RackMultipart20141106-12038-1xiild8>>},
#  "image4"=>
#   {"image4"=>
#     #<ActionDispatch::Http::UploadedFile:0x007f9c62de1e70
#      @content_type="image/jpeg",
#      @headers="Content-Disposition: form-data; name=\"home[image4][image4]\"; filename=\"tumblr_static_cheese_205_1362800142.jpg\"\r\nContent-Type: image/jpeg\r\n",
#      @original_filename="tumblr_static_cheese_205_1362800142.jpg",
#      @tempfile=#<File:/var/folders/45/c8b4jw614732cgddh_lrd52c0000gn/T/RackMultipart20141106-12038-8vdtip>>}}

  def update
    @home = Home.find(params[:id])
    # binding.pry
    # @home.update_attributes(home_params)

    params.require(:home).slice(:image1, :image2, :image3, :image4).each do |image_number, image_data|
      image_params = image_data.require(image_number)
      image = Image.new(image_content_type: image_params.content_type,
                        image_file_size: image_params.size,
                        image_file_name: image_params.original_filename)
      @home.images << image
    end

    @home.save
    #
    # @home.images << Image.new(image_content_type: "image/png", image_file_name: "baby.png") unless @home.images
    # @home.images[0] = params[:home][:image]
    # @home.images.save

    # if @home.images.count > 4
    #   @home.images.last.destroy
    # end

    if @home.save
      gflash :now,  :success => "Home page was successfully updated."
      redirect_to admin_path(business.slug)
    else
      raise @home.errors.full_messages.inspect
      gflash :now,  :error => "Page was not updated. Please try again."
      render :edit
    end
  end

  private
  def home_params
    params.require(:home).permit(
                                  :tagline1,
                                  :tagline2,
                                  :tagline3,
                                  :tagline4,
                                  :caption1,
                                  :caption2,
                                  :caption3,
                                  :caption4,
                                  :images
                                  # images_attributes: [:image1, :image2, :image3, :image4]
                                  )
  end
end
