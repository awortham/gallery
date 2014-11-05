class RemoveImageColumnFromAbouts < ActiveRecord::Migration
  def change
    remove_column :abouts, :image_file_name, :string
  end
end
