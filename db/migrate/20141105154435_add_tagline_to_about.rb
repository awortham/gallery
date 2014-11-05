class AddTaglineToAbout < ActiveRecord::Migration
  def change
    add_column :abouts, :tagline, :string
  end
end
