class RemoveRolesColumnsFromUser < ActiveRecord::Migration
  def change
    remove_column :users, :admin, :string
    remove_column :users, :platform_admin, :string
  end
end
