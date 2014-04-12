class AddColorToPictures < ActiveRecord::Migration
  def change
    add_column :pictures, :color, :string
  end
end
