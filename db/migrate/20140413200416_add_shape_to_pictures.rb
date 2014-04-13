class AddShapeToPictures < ActiveRecord::Migration
  def change
    add_column :pictures, :shape, :string
  end
end
