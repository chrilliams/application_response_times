# encoding: UTF-8
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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20140818170816) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "business_systems", force: true do |t|
    t.string   "business_service_name"
    t.integer  "metric_id"
    t.decimal  "current_sla_kpi"
    t.decimal  "target"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "events", force: true do |t|
    t.string   "name"
    t.datetime "start_time"
    t.datetime "finish_time"
    t.integer  "duration"
    t.string   "system"
    t.string   "sub_system"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "ref_datum_id"
  end

  add_index "events", ["ref_datum_id"], name: "index_events_on_ref_datum_id", using: :btree
  add_index "events", ["start_time"], name: "index_events_on_start_time", using: :btree

  create_table "log_files", force: true do |t|
    t.string   "file_name"
    t.string   "line_format"
    t.string   "fields"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "business_system_id"
  end

  add_index "log_files", ["business_system_id"], name: "index_log_files_on_business_system_id", using: :btree

  create_table "ref_data", force: true do |t|
    t.string   "code"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "business_system_id"
  end

  add_index "ref_data", ["business_system_id"], name: "index_ref_data_on_business_system_id", using: :btree

  create_table "stages", force: true do |t|
    t.datetime "ev_time"
    t.string   "app_id"
    t.string   "code"
    t.string   "description"
    t.string   "conversation_id"
    t.string   "system"
    t.string   "sub_system"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "stages", ["app_id"], name: "index_stages_on_app_id", using: :btree
  add_index "stages", ["code"], name: "index_stages_on_code", using: :btree

end
