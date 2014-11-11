class Platform::PlatformController < ApplicationController
  before_filter :verify_business

  def verify_business
   redirect_to home_path(business.slug) unless business.slug == "gallery"
  end
end
