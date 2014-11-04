class ChangeNamesForHome < ActiveRecord::Migration
  def change
    rename_column :homes, :caption, :caption1
    rename_column :homes, :tagline, :tagline1
  end
end
