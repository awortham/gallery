class Admin::CategoriesController < Admin::AdminController
  def index
    @categories = Category.all
  end

  def new
    @category = Category.new
  end

  def edit
    @category = Category.find(params[:id])
  end

  def create
    @category = Category.new(category_params)

    if @category.save
      gflash :now, :success => "Category Successfully Created"
      redirect_to admin_path(business.slug)
    else
      gflash :now, :error => @category.errors.full_messages.to_sentence
      render :new
    end
  end

  def update
    @category = Category.find(params[:id])

    if @category.update(category_params)
      gflash :now, :success => "Category was successfully updated."
      redirect_to admin_categories_path(business.slug)
    else
      gflash :now, :error => "Category was not updated. Please try again."
      render :new
    end
  end

  def destroy
    Category.find(params[:id]).destroy
    gflash :now,  :success => "Category was successfully deleted."

    redirect_to admin_path(business.slug)
  end

  private
  def category_params
    params.require(:category).permit(:title, :description)
  end
end
