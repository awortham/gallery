class OrderConfirmationJob
  @queue = :email

  def self.perform(user_id, business_id, order_id)
    Notifier.order_confirmation(user_id, business_id, order_id).deliver
  end
end
