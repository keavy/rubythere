class AddRegOpenToEvents < ActiveRecord::Migration
  def self.up
    add_column :events, :reg_open, :boolean, :default => 0
  end

  def self.down
    remove_column :events, :reg_open
  end
end
