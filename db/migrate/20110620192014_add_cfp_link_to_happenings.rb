class AddCfpLinkToHappenings < ActiveRecord::Migration
  def self.up
    add_column :happenings, :cfp_url, :string
  end

  def self.down
    remove_column :happenings, :cfp_url
  end
end