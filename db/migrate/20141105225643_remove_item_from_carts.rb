class RemoveItemFromCarts < ActiveRecord::Migration
  def change
    remove_column :carts, :item_id, :integer
  end
end
