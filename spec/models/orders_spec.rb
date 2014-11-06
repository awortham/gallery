require 'rails_helper'

describe 'order' do

  before do
    @order = Order.create(user_id: 1, line_items: [LineItem.create(cart_id: 1, item_id: 1)], status: 'ordered', pickup_or_delivery: 'delivery')
  end

  it 'is valid' do
    expect(@order).to be_valid
  end

  it 'has a user_id' do
    @order.user_id = nil
    expect(@order).to_not be_valid
  end

  it 'requires user to choose either pickup or delivery option' do
    @order.pickup_or_delivery = nil
    expect(@order).to_not be_valid

    @order.pickup_or_delivery = "I come get it"
    expect(@order).to_not be_valid
  end

  it 'requires a status of "ordered", "completed", or "cancelled"' do
    @order.status = nil
    expect(@order).to_not be_valid

    @order.status = "layaway"
    expect(@order).to_not be_valid
  end
end
