class CreateAbouts < ActiveRecord::Migration
  def change
    create_table :abouts do |t|
      t.string :name
      t.text :bio
      t.integer :business_id

      t.timestamps
    end
  end
end
