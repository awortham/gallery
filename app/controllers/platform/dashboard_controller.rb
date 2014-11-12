class Platform::DashboardController < Platform::PlatformController
  before_filter :verify_platform, only: :index

  def home
  end

  def index
  end

  def create
    @business.slug = Business.new(business_params)
    if @business.save
      gflash :now, :success => "Awesome! Account Created"
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
