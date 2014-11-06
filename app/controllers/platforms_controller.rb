class PlatformsController < ApplicationController

  def admin
    if users.platform_admin == "true"

    else
      redirect_to 'somewhere over the rainbow'
    end
  end

end
