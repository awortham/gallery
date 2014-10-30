require 'rails_helper'

describe 'cart' do

  before do
    @cart = Cart.new({})
  end

  it "is empty when there are no items" do
    expect(@cart.total_quantity).to eq(0)
  end

  it "reads back the value for the added item" do
    @cart.add_line_item(5, 2)
    expect(@cart.line_item_quantity(5)).to eq(2)
    @cart.add_line_item(4, 3)
    expect(@cart.line_item_quantity(4)).to eq(3)
  end

  it "increments quantity when it is empty" do
    @cart.add_line_item(2, 1)
    expect(@cart.line_item_quantity(2)).to eq(1)
  end

  it "increments quantity when it has some in cart" do
    @cart.add_line_item(2, 1)
    @cart.add_line_item(2, 1)
    expect(@cart.line_item_quantity(2)).to eq(2)
  end

  it "gives 0 as the quantity of an item that has never been added" do
    expect(@cart.line_item_quantity(2)).to eq(0)
  end

  it "adds multiple items to multiple items" do
    @cart.add_line_item(2, 3)
    @cart.add_line_item(2, 6)
    expect(@cart.line_item_quantity(2)).to eq(9)
  end
end
