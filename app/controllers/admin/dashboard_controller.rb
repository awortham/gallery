class Admin::DashboardController < Admin::AdminController
  before_filter :set_categories, only: :index

  def index
    @users = User.all
  end

  def edit
    @about = About.find(params[:id])
  end

  def update

     @about = About.find(params[:id])
     @about.update_attributes(about_params)
     @about.image = Image.new unless @about.image
     @about.image.image = params[:about][:image]
     @about.image.save

     if @about.save
       gflash :now,  :success => "About page was successfully updated."
       redirect_to admin_path(business.slug)
     else
       gflash :now,  :error => "Page was not updated. Please try again."
       render :new
     end
  end

  private
  def about_params
    params.require(:about).permit(:name, :bio, :tagline)
  end
end
