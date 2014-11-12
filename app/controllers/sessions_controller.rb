class SessionsController < ApplicationController
  skip_before_action :ensure_member

  def new
  end

  def create
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password]) && user.admin?
      session[:user_id] = user.id
      associate_cart(user)
      gflash :now, :success => 'Successfully Logged In'
      user.save
      redirect_to admin_path(business.slug)
    elsif user && user.authenticate(params[:password])
      session[:user_id] = user.id
      user.cart ||= cart
      gflash :now, :success  => 'Successfully Logged In'
      user.save
      redirect_to :back
    else
      gflash :now, :error => 'Invalid login. Please try again.'
      redirect_to :back
    end
  end

  def destroy
    session.clear
    gflash :now, :success => 'Successfully Logged Out.'
    if business.slug == 'gallery'
      redirect_to platform_path(business.slug)
    else
      redirect_to home_path(business.slug)
    end
  end

  private
    
    def associate_cart(user)
      if cart.line_items.present? && user.cart && user.cart.line_items.present?
        user.cart.line_items << cart.line_items
      else
        user.cart ||= cart
      end
    end
end
