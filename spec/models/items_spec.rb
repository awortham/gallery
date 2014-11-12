require 'spec_helper'


describe "creating an item" do
  it "should have a title" do
    item = Item.new(title: "Crickets", description: "crunchy")
    expect(item.title).to eq "Crickets"
  end

  it "should have a description" do
    item = Item.new(description: "Crunchy")
    expect(item.description).to eq "Crunchy"
  end

  it "should have dimensions" do
    item = Item.new(dimensions: "20 x 20")
    expect(item.dimensions).to eq "20 x 20"
  end

  it "should have a price" do
    item = Item.new(price: 9.99)
    expect(item.price).to eq 9.99
  end

  it "should be invalid without title" do
    item = Item.new(description: "Crunchy")
    expect(item).to_not be_valid
  end

  it "should be invalid without a category" do
    item = Item.new(title: "Fish", description: "Fishy")
    expect(item).to_not be_valid
  end

  it "should be invalid unless price is a positive integer" do
    item = Item.new(title: "Oranges", description: "Tart")

    item.price = "dog"
    expect(item).to_not be_valid

    item.price = -1
    expect(item).to_not be_valid

    item.price = 0
    expect(item).to_not be_valid
  end
end
