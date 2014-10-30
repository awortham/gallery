class ItemsController < ApplicationController

  def index
    @categories = business.categories.all
    @items = business.items.all
  end

  def show
    @item = Item.find(params[:id])
    @user = User.new
  end

end
