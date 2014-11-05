class PagesController < ApplicationController
  include PagesHelper

  before_filter :verify_admin, only: [:admin]

  def index
  end

  def menu
    @categories = Category.all
    @user = User.new
    @home = business.home
  end

  def about
    @user = User.new
    @about = business.about
  end

  def code
    redirect_to 'https://github.com/awortham/Gallery'
  end

  def cart_route
    @user = User.new
    if cart.line_items.empty?
      redirect_to home_path(@business.slug)
      gflash :now, :notice => "Your cart is currently empty."
    else
      render 'cart'
    end
  end
end
