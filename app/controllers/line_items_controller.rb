class LineItemsController < ApplicationController

  def create
    cart.add_line_item(params[:id], params[:quantity][:quantity])
    gflash :now, :success => "#{params[:quantity][:quantity]} #{find_item(params[:id]).title}".pluralize + " sucessfully added to your cart!"
    cart.save
    redirect_to request.referer
   end

  def update
    cart.update_item(params[:id], params[:quantity].to_i)
    gflash :now, :success => "#{find_item(params[:id]).title} has been successfully updated."
    cart.save
    redirect_to :back
  end

  def destroy
    cart.delete_item(params[:id])
    gflash :now, :notice => "#{find_item(params[:id]).title} has been successfully deleted."
    cart.save
    redirect_to :back
  end

end
