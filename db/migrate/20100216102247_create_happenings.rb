class CreateHappenings < ActiveRecord::Migration
  def self.up
    create_table :happenings do |t|
      t.integer :event_id
      t.string :url, :cached_slug
      t.text :description, :description_f
      t.datetime :start_at, :end_at, :cfp_closes_at
      t.boolean :cfp_open, :default => 0
      t.boolean :open_for_reg, :default => 0
      t.decimal :cost, :precision => 10, :scale => 2
      t.string :currency
      t.boolean :sold_out, :default => 0
      t.boolean :childcare, :default => 0
      t.integer :location_id, :venue_id
      t.timestamps
    end
    
    Event.all.each do |event|
      Happening.create( :event_id      => event.id,
                        :url           => event.url,
                        :description   => event.description,
                        :description_f => event.description_formatted,
                        :start_at      => event.start_date,
                        :end_at        => event.end_date,
                        :cfp_closes_at => event.cfp_close_date,
                        :cfp_open      => event.proposals_open,
                        :open_for_reg  => event.reg_open,
                        :cost          => event.cost,
                        :currency      => event.currency,
                        :sold_out      => event.sold_out,
                        :location_id   => event.location_id
                        )
    end
  end

  def self.down
    drop_table :happenings
  end
end
