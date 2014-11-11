class CreateHomes < ActiveRecord::Migration
  def change
    create_table :homes do |t|
      t.text :tagline
      t.integer :business_id

      t.timestamps
    end
  end
end
