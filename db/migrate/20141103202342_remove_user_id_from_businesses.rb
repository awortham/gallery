class RemoveUserIdFromBusinesses < ActiveRecord::Migration
  def change
    remove_column :businesses, :user_id
  end
end
