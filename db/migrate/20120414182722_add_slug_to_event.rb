class AddSlugToEvent < ActiveRecord::Migration
  def self.up
    add_column :events, :slug, :string
    add_index :events, :slug, unique: true
    remove_column :events, :cached_slug

    drop_table :slugs
  end

  def self.down
    remove_column :events, :slug
  end
end