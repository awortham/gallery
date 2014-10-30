class AddBusinessIdToCategories < ActiveRecord::Migration
  def change
    add_column :categories, :business_id, :integer
  end
end
