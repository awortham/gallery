class RemovePaperclipColumnsFromAbout < ActiveRecord::Migration
  def change
    remove_column :abouts, :image_file_name
    remove_column :abouts, :image_content_type
    remove_column :abouts, :image_file_size
    remove_column :abouts, :image_updated_at
  end
end
