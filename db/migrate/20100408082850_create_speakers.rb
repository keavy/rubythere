class CreateSpeakers < ActiveRecord::Migration
  def self.up
    create_table :speakers do |t|
      t.string :first_name, :last_name, :company, :twitter, :email
      t.timestamps
    end
  end

  def self.down
    drop_table :speakers
  end
end
