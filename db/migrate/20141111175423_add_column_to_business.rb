class AddColumnToBusiness < ActiveRecord::Migration
  def change
    add_column :businesses, :status, :string, default: "retired"
  end
end
