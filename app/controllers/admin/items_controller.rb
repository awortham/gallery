class Admin::ItemsController < Admin::AdminController
  def index
    @categories = business.categories.includes(:items).where(items: {business_id: business.id})
  end

  def show
  end

  def new
    @item       = Item.new
    @categories = Category.all
  end

  def edit
    @item = Item.find(params[:id])
  end

  def create
    @item = Item.new(item_params)
    @item.update_attributes(item_params)
    @item.categories = Category.where(id: params["item"]["categories"])
    if @item.save
      gflash :now,  :success => "Item Successfully Created"
      redirect_to admin_items_path(business.slug)
    else
      gflash :now,  :error => @item.errors.full_messages.to_sentence
      render :new
    end
  end

  def update
    @item = Item.find(params[:id])
    @item.update_attributes(item_params)
    @item.categories = Category.where(id: params["item"]["categories"])
    if @item.save
      gflash :now,  :success => "Item was successfully updated."
      redirect_to admin_items_path(business.slug)
    else
      gflash :now,  :error => "Item was not updated. Please try again."
      render :new
    end
  end

  def destroy
    Item.find(params[:id]).destroy
    gflash :now,  :success => "Item was successfully deleted."

    redirect_to admin_items_path(business.slug)
  end

  private

  def item_params
    params.require(:item).permit(:title, :description, :price, :status, :image, :categories)
  end

  def check_category
    @item.categories.collect {|category| category.id}
  end

end
