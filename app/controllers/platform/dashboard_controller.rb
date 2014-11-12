class Platform::DashboardController < Platform::PlatformController
  before_filter :verify_platform, only: :index

  def home
  end

  def index
    @users = User.all
    @businesses = Business.all
  end

  def edit
    @edit_business = Business.find(params[:id])
  end

  def update
    @update_business = Business.find(params[:id])
    @update_business.status = (params[:business][:status])
    if @update_business.save
      gflash :now, :success => "Business was successfully updated!"
      redirect_to platform_dashboard_index_path
    else
      gflash :now, :error => "Business was not updated."
      render :edit
    end
  end

  def create
    @business = Business.new(business_params)
    if @business.save
      gflash :now, :success => "Account created."
      redirect_to :back
    else
      gflash :now, :error =>  @business.errors.full_messages.to_sentence
      redirect_to :back
    end
  end

  private
  def verify_platform
    redirect_to platform_path(business.slug) unless current_user && current_user.platform_admin?
  end

  def business_params
    params.require(:business).permit(:name, :email, :business_name, :business_idea)
  end
end
