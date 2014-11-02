# require 'spec_helper'


# describe "creating an item" do
#   it "should have a title" do
#     item = Item.new(title: "Crickets", description: "crunchy")
#     expect(item.title).to eq "Crickets"
#   end

#   it "should have a description" do
#     item = Item.new(description: "Crunchy")
#     expect(item.description).to eq "Crunchy"
#   end

#   it "should have a price" do
#     item = Item.new(price: 9.99)
#     expect(item.price).to eq 9.99
#   end

#   it "should be invalid without title" do
#     item = Item.new(description: "Crunchy")
#     expect(item).to_not be_valid
#   end

#   it "should be invalid without a description" do
#     item = Item.new(title: "Crickets")
#     expect(item).to_not be_valid
#   end

#   it "should be invalid without a category" do
#     item = Item.new(title: "Fish", description: "Fishy")
#     expect(item).to_not be_valid
#   end

#   it "should be invalid unless price is a positive integer" do
#     item = Item.new(title: "Oranges", description: "Tart")

#     item.price = "dog"
#     expect(item).to_not be_valid

#     item.price = -1
#     expect(item).to_not be_valid

#     item.price = 0
#     expect(item).to_not be_valid
#   end

#   def new_product(image_url)
#     Item.create(
#       title:           "Carrots",
#       description:     "Vitamin K",
#       price:           1,
#       image_file_name: image_url,
#       )
#   end

#   it "should have an image_url with a valid extension" do
#     category = Category.create!(title: "Veggies", description: "Juicy.")
#     good     = %w{ donut.gif donut.jpg donut.png Donut.JPG Donut.Jpg http://a.b.c/x/y/z/donut.gif }
#     bad      = %w{ donut.doc donut.gif/more donut.gif.more }

#     good.each do |file|
#       item = new_product(file)
#       item.categories << category

#       expect(item).to be_valid
#     end

#     bad.each  do |file|
#       item = new_product(file)
#       item.categories << category
#       expect(item).to_not be_valid
#     end
#   end
# end
