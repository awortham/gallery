class AddColumnsToHome < ActiveRecord::Migration
  def change
    add_column :homes, :tagline2, :text
    add_column :homes, :tagline3, :text
    add_column :homes, :tagline4, :text
    add_column :homes, :caption, :text
    add_column :homes, :caption2, :text
    add_column :homes, :caption3, :text
    add_column :homes, :caption4, :text
  end
end
