class ItemsController < ApplicationController

  def index
    @categories = business.categories.all
    @items = business.items.all
  end

  def show
    @item = business.items.find(params[:id])
    @user = business.users.new
  end

end
