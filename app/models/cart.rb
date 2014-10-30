class Cart
  def initialize(session)
    @session ||= session
  end

  def line_items
    @session[:cart_items] ||= {}
  end

  def line_item_quantity(item_id)
    line_items[item_id].to_i
  end

  def add_line_item(item_id, quantity)
    line_items[item_id] = line_items[item_id].to_i + quantity.to_i
  end

  def total_quantity
    line_items.values.reduce(0) {|sum, quantity| sum += quantity.to_i }
  end

  def subtotal
    total = 0
    line_items.each do |item_id, quantity|
      total += Item.find(item_id).price * quantity.to_i
    end
    total
  end

  def inspect
    line_items.inspect
  end

  def update_item(item_id, quantity)
    line_items[item_id] = quantity
  end

  def delete_item(item_id)
    line_items.delete(item_id)
  end

  def line_item_total(item_id, quantity)
    Item.find(item_id).price.to_i * quantity.to_i
  end

  def line_item_subtotal(item_id, quantity)
    Item.find(item_id).price * quantity
  end
end
