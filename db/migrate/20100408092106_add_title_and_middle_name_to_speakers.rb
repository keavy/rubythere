class AddTitleAndMiddleNameToSpeakers < ActiveRecord::Migration
  def self.up
    add_column :speakers, :title, :string
    add_column :speakers, :middle_name, :string
  end

  def self.down
    remove_column :speakers, :title
    remove_column :speakers, :middle_name
  end
end
