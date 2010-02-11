class AddTwitterNameToEvents < ActiveRecord::Migration
  def self.up
    add_column :events, :twitter, :string
  end

  def self.down
    remove_column :events, :twitter
  end
end
