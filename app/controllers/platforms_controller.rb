class PlatformsController < ApplicationController

  def show
    if current_user.platform_admin
      redirect_to platform_admin_path
    end
  end

end
