class Cart < ActiveRecord::Base
  belongs_to :user
  has_many :line_items

  def line_item_quantity(item_id)
    line_items.present? ? line_items.where(item_id: item_id).first.quantity : 0
  end

  def add_line_item(item_id, quantity)
    line_items.build(item_id: item_id, quantity: quantity)
  end

  def total_quantity
    line_items.reduce(0) { |sum, i| sum + i.quantity }
  end

  def subtotal
    total = 0
    line_items.each do |i|
      total += Item.find(i.item_id).price * i.quantity
    end
    total
  end

  # def inspect
  #   line_items.inspect
  # end

  def update_item(item_id, quantity)
    li = line_items.find_by(item_id: item_id)
    li.quantity = quantity
    li.save
  end

  def delete_item(item_id)
    li = line_items.find_by(item_id: item_id)
    li.destroy
  end

  def line_item_total(item_id, quantity)
    Item.find(item_id).price.to_i * quantity.to_i
  end

  def line_item_subtotal(item_id, quantity)
    Item.find(item_id).price * quantity
  end
end
