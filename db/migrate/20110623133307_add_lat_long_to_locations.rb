class AddLatLongToLocations < ActiveRecord::Migration
  def self.up
    add_column :locations, :lat_long, :string
  end

  def self.down
    remove_column :locations, :lat_long
  end
end