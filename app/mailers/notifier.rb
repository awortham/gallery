class Notifier < ActionMailer::Base
  default from: "from@example.com"

  def welcome(user_id, business_id)
    @business = Business.find(business_id)
    @user = User.find(user_id)
    mail(to: @user.email, subject: "Welcome to #{@business.name}")
  end

  def order_confirmation(user_id, business_id, order_id)
    @business = Business.find(business_id)
    @user = User.find(user_id)
    @order = Order.find(order_id)
    mail(to: @user.email, subject: "Order Confirmation")
  end

  def request_business(business_id, admin_id)
    @business = Business.find(business_id)
    admin = User.find(admin_id)
    mail(to: admin.email, subject: "Request for new store")
  end

  def approval(business_id)
    @business = Business.find(business_id)
    mail(to: @business.email, subject: "Approved!")
  end

  def denial(business_id)
    @business = Business.find(business_id)
    mail(to: @business.email, subject: "unapproved")
  end
end
