class RemoveOldFieldsFromEvents < ActiveRecord::Migration
  def self.up
    remove_column :events, "start_date"
    remove_column :events, "end_date"
    remove_column :events, "cfp_date"
    remove_column :events, "reg_date"
    remove_column :events, "cfp_close_date"
    remove_column :events, "cost"
    remove_column :events, "currency"
    remove_column :events, "sold_out"
    remove_column :events, "childcare"
    remove_column :events, "location_id"
    remove_column :events, "venue_id"
    remove_column :events, "reg_open"
    remove_column :events, "proposals_open"
  end

  def self.down
    add_column :events, "start_date", :datetime
    add_column :events, "end_date", :datetime
    add_column :events, "cfp_date", :datetime 
    add_column :events, "reg_date",  :datetime 
    add_column :events, "cfp_close_date", :datetime 
    add_column :events, "cost", :decimal, :precision => 10, :scale => 2, :default => 0.0
    add_column :events, "currency", :string  
    add_column :events, "sold_out", :boolean, :default => false
    add_column :events, "childcare", :boolean, :default => false
    add_column :events, "location_id", :integer  
    add_column :events, "venue_id", :integer 
    add_column :events, "reg_open", :boolean, :default => false
    add_column :events, "proposals_open", :boolean, :default => false
  end
end
