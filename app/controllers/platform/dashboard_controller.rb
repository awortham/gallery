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
      Resque.enqueue(ApprovalJob, @update_business.id) if @update_business.status == "active"
      Resque.enqueue(DenialJob, @update_business.id) if @update_business.status == "retired"
      gflash :now, :success => "Business successfully updated!"
      redirect_to platform_dashboard_index_path
    else
      gflash :now, :error => "Business was not updated."
      render :edit
    end
  end

  def create
    @business = Business.create(buziness_params)
    @business.slug = @business.business_name.downcase.split.join
    @business.about = About.create
    @business.home = Home.create
    @business.users << User.create(name: @business.name, password: "password", password_confirmation: "password", email: @business.email, admin: "true", username: @business.name)
    if @business.save
      Resque.enqueue(RequestBusinessJob, @business.id)
      gflash :now, :success => "Thanks! We'll be in touch soon."
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

  def buziness_params
    params.require(:buziness).permit(:name, :email, :business_name, :business_idea)
  end
end
