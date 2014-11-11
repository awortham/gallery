class CreateHomeImages < ActiveRecord::Migration
  def change
    create_table :home_images do |t|
      t.integer :home_id
      t.integer :image_id
      t.string :caption
      t.string :tagline

      t.timestamps
    end
  end
end
