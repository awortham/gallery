class Admin::DashboardController < Admin::AdminController
  before_filter :set_categories, only: :index

  def index
    @users = business.users
  end

  def edit
    @about = About.find(params[:id])
  end

  def update
     @about = About.find(params[:id])

     @about.update_attributes(about_params)

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
    params.require(:about).permit(:name, :bio, :tagline, :image_id)
  end
end
