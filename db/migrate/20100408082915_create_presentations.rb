class CreatePresentations < ActiveRecord::Migration
  def self.up
    create_table :presentations do |t|
      t.integer :speaker_id, :talk_id, :happening_id
      t.timestamps
    end
  end

  def self.down
    drop_table :presentations
  end
end
