class RemoveAuthlogicUserFields < ActiveRecord::Migration
  def self.up
    remove_column :users, :crypted_password
    remove_column :users, :password_salt
    remove_column :users, :persistence_token
    change_column :users, :email, :string, :null => true
    add_column :users, :admin, :boolean, :default => false
  end
  
  def self.down
    add_column :users, :crypted_password, :string, :null => false
    add_column :users, :password_salt, :string, :null => false
    add_column :users, :persistence_token, :string, :null => false
    change_column :users, :email, :string, :null => false
    remove_column :users, :admin
  end
end
