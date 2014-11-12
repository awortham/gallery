class OrdersController < ApplicationController
  before_filter :active_orders, only: [:index]

  def index
    if current_user.nil?
      redirect_to home_path(business.slug)
    elsif current_user.admin
      @recent_orders = active_orders
      @paid_orders = paid_orders
      @cancelled_orders = cancelled_orders
    else
      redirect_to home_path(business.slug)
    end
  end

  def new
    @user = User.new
    @order = Order.new(pickup_or_delivery: params[:pickup_option])
    @line_items = cart.line_items
    @address = Address.find_by(user_id: current_user.id)
    @pickup_option = params[:pickup_option]
  end

  def create
    @order = Order.new(order_params)
    @order.line_items = cart.line_items
    if @order.save
      cart.line_items.clear
      Notifier.order_confirmation(current_user.id, @business.id, @order.id).deliver
      redirect_to order_path(@business.slug, @order.id)
    else
      gflash :now, :error =>  @order.errors.full_messages.to_sentence
      redirect_to :back
    end
  end

  def show
    @order = Order.find_by(id: params[:id])
    if current_user.admin == true || @order.user_id == current_user.id
      @address = Address.find_by(id: @order.address_id)
    else
      redirect_to home_path(business.slug)
    end
  end

  def update
    @order = Order.find_by(id: params[:id])
    @order.update(status: params[:status])

    if params[:quantity] && params[:item_id]
      @order.line_items_will_change!
      @order.update_line_items(params[:item_id], params[:quantity])
      @order.save
    end
    if user_admin?
      redirect_to orders_path(business.slug)
    else
      redirect_to user_orders_path(business.slug, current_user.id)
    end
  end

  private

  def order_params
    params.require(:order).permit(:user_id, :address_id, :status, :pickup_or_delivery, :line_items)
  end

  def paid_orders
    Order.all.where(status: "completed")
  end

  def cancelled_orders
    Order.all.where(status: "cancelled")
  end

  def active_orders
    Order.all.where(status: "ordered")
  end

  def user_admin?
    User.find_by_id(current_user).admin == true
  end

end
