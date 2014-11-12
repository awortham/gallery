class AddDimensionsToItem < ActiveRecord::Migration
  def change
    add_column :items, :dimensions, :string
  end
end
