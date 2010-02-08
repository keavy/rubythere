class CreateLocations < ActiveRecord::Migration
  def self.up
    create_table :locations do |t|
      t.string :venue, :street_address, :street_address2, :city, :state, :country
      t.timestamps
    end
  end

  def self.down
    drop_table :locations
  end
end
