require 'rails_helper'

describe 'cart' do

  before do
    @cart = Cart.create
  end

  it "is empty when there are no items" do
    expect(@cart.total_quantity).to eq(0)
  end

  it "reads back the value for the added item" do
    LineItem.create!(item_id: 5, quantity: 2, cart: @cart)
    @cart.add_line_item(5, 2)
    @cart.save
    expect(@cart.line_item_quantity(5)).to eq(2)
  end

  it "increments quantity when it is empty" do
    LineItem.create!(item_id: 2, quantity: 1, cart: @cart)
    @cart.add_line_item(2, 1)
    expect(@cart.line_item_quantity(2)).to eq(1)
  end

  it "gives 0 as the quantity of an item that has never been added" do
    expect(@cart.line_item_quantity(2)).to eq(0)
  end
end
