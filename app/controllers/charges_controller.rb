class ChargesController < ApplicationController

  def new
    if !current_user
      redirect_to home_path(business.slug)
    end
    @order = Order.find_by_id(params[:id])
  end

  def create
    @order = Order.find_by_id(params[:id])
    @amount = @order.stripe_total

    customer = Stripe::Customer.create(
    :email => 'jupiterjazz8@gmail.com',
    :card  => params[:stripeToken]
    )

    charge = Stripe::Charge.create(
    :customer    => customer.id,
    :amount      => @amount,
    :description => 'Rails Stripe customer',
    :currency    => 'usd'
    )

    @order.status = "completed"
    @order.save
    gflash :now, :success => "Thanks.Your order is now paid. You will be recieving a confirmation email shortly."

  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to charges_path(business.slug)
  end
end
