class CreateEvents < ActiveRecord::Migration
  def self.up
    create_table :events do |t|
      t.string :name, :url
      t.text :description, :description_formatted
      t.datetime :start_date, :end_date, :cfp_date, :reg_open_date, :proposal_close_date
      t.decimal :cost, :precision => 10, :scale => 2, :default => (0.0)
      t.string :currency
      t.boolean :sold_out, :default => 0
      t.boolean :childcare, :default => 0
      t.timestamps
    end
  end

  def self.down
    drop_table :events
  end
end
