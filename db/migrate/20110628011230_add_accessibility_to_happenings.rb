class AddAccessibilityToHappenings < ActiveRecord::Migration
  def self.up
    add_column :happenings, :accessible, :boolean, :default => 0
  end

  def self.down
    remove_column :happenings, :accessible
  end
end