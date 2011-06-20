# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20110620192014) do

  create_table "events", :force => true do |t|
    t.string   "name"
    t.string   "url"
    t.text     "description"
    t.text     "description_formatted"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "twitter"
    t.string   "cached_slug"
    t.boolean  "approved",              :default => false
    t.integer  "submitter_id"
  end

  create_table "happenings", :force => true do |t|
    t.integer  "event_id"
    t.string   "url"
    t.string   "cached_slug"
    t.text     "description"
    t.text     "description_f"
    t.datetime "start_at"
    t.datetime "end_at"
    t.datetime "cfp_closes_at"
    t.boolean  "cfp_open",                                     :default => false
    t.boolean  "open_for_reg",                                 :default => false
    t.decimal  "cost",          :precision => 10, :scale => 2
    t.string   "currency"
    t.boolean  "sold_out",                                     :default => false
    t.boolean  "childcare",                                    :default => false
    t.integer  "location_id"
    t.integer  "venue_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "cfp_url"
  end

  create_table "locations", :force => true do |t|
    t.string   "city"
    t.string   "state"
    t.string   "country"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "presentations", :force => true do |t|
    t.integer  "speaker_id"
    t.integer  "talk_id"
    t.integer  "happening_id"
    t.boolean  "keynote",      :default => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sessions", :force => true do |t|
    t.string   "session_id", :null => false
    t.text     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sessions", ["session_id"], :name => "index_sessions_on_session_id"
  add_index "sessions", ["updated_at"], :name => "index_sessions_on_updated_at"

  create_table "slugs", :force => true do |t|
    t.string   "name"
    t.integer  "sluggable_id"
    t.integer  "sequence",                     :default => 1, :null => false
    t.string   "sluggable_type", :limit => 40
    t.string   "scope",          :limit => 40
    t.datetime "created_at"
  end

  add_index "slugs", ["name", "sluggable_type", "scope", "sequence"], :name => "index_slugs_on_n_s_s_and_s", :unique => true
  add_index "slugs", ["sluggable_id"], :name => "index_slugs_on_sluggable_id"

  create_table "speakers", :force => true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "company"
    t.string   "twitter"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "title"
    t.string   "middle_name"
  end

  create_table "submitters", :force => true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.string   "twitter"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "talks", :force => true do |t|
    t.string   "title"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "screen_name", :limit => 30
    t.string   "atoken"
    t.string   "asecret"
    t.boolean  "admin",                     :default => false
  end

  create_table "venues", :force => true do |t|
    t.string   "name"
    t.string   "street_address"
    t.string   "street_address2"
    t.integer  "location_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
