class LineItemsController < ApplicationController

  def create
    cart.add_line_item(params[:id], params[:quantity][:quantity])
    gflash :now, :success => "#{params[:quantity][:quantity]} #{find_item(params[:id]).title}".pluralize + " sucessfully added to your cart!"
    redirect_to photos_path(business.slug)
   end

  def update
    cart.update_item(params[:id], params[:quantity])
    gflash :now, :success => "#{find_item(params[:id]).title} has been successfully updated."
    redirect_to :back
  end

  def destroy
    cart.delete_item(params[:id])
    gflash :now, :notice => "#{find_item(params[:id]).title} has been successfully deleted."
    redirect_to :back
  end

end
