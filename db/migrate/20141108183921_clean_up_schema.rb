class CleanUpSchema < ActiveRecord::Migration
  def change
    #homes
    remove_column :homes, :tagline1
    remove_column :homes, :tagline2
    remove_column :homes, :tagline3
    remove_column :homes, :tagline4
    remove_column :homes, :caption1
    remove_column :homes, :caption2
    remove_column :homes, :caption3
    remove_column :homes, :caption4
    remove_column :homes, :image_file_name
    remove_column :homes, :image_content_type
    remove_column :homes, :image_file_size
    remove_column :homes, :image_updated_at

    #images
    remove_column :images, :imageable_id
    remove_column :images, :imageable_type
    add_column :images, :business_id, :integer
    add_index  :images, :business_id

    #items
    remove_column :items, :image_file_name
    remove_column :items, :image_content_type
    remove_column :items, :image_file_size
    remove_column :items, :image_updated_at
    add_column :items, :image_id, :integer
    add_index :items, :image_id

    #abouts
    add_column :abouts, :image_id, :integer
    add_index :abouts, :image_id
  end
end
