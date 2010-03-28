class CreateSubmitters < ActiveRecord::Migration
  def self.up
    create_table :submitters do |t|
      t.string :first_name, :last_name, :email, :twitter
      t.timestamps
    end
  end

  def self.down
    drop_table :submitters
  end
end
