class CreateVenues < ActiveRecord::Migration
  def self.up
    create_table :venues do |t|
      t.string :name, :street_address, :street_address2
      t.integer :location_id
      t.timestamps
    end
  end

  def self.down
    drop_table :venues
  end
end
