class Admin::DashboardController < Admin::AdminController
  before_filter :set_categories, only: :index

  def index
    @users = User.all
  end

end
