class AddApprovedToEvents < ActiveRecord::Migration
  def self.up
    add_column :events, :approved, :boolean, :default => 0
  end

  def self.down
    remove_column :events, :approved
  end
end
