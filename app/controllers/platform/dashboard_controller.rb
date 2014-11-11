class Platform::DashboardController < Platform::PlatformController
  before_filter :verify_platform, only: :index

  def new
  end

  def index
  end

  private
  def verify_platform
    redirect_to platform_path(business.slug) unless current_user && current_user.platform_admin?
  end
end
