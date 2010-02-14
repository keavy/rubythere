class AddProposalsOpenToEvents < ActiveRecord::Migration
  def self.up
    add_column :events, :proposals_open, :boolean, :default => 0
  end

  def self.down
    remove_column :events, :proposals_open
  end
end
