class AddLatitudeAndLongitudeToModel < ActiveRecord::Migration
  def change
    add_column :locations, :latitude, :float
    add_column :locations, :longitude, :float
    remove_column :locations, :lat_long
  end
end
