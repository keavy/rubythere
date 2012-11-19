class ChangeUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :provider, :string
    add_column :users, :uid, :string
    add_column :users, :name, :string
  end

  def self.down
    remove_column :users, :atoken
    remove_column :users, :asecret
    remove_column :users, :email
  end
end
