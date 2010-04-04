class AddSubmitterIdToEvents < ActiveRecord::Migration
  def self.up
    add_column :events, :submitter_id, :integer
  end

  def self.down
    remove_column :events, :submitter_id
  end
end
