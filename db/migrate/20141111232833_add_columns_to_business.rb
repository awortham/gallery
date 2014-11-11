class AddColumnsToBusiness < ActiveRecord::Migration
  def change
    add_column :businesses, :email, :string
    add_column :businesses, :business_name, :string
    add_column :businesses, :business_idea, :text
  end
end
