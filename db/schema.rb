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

ActiveRecord::Schema.define(version: 20151207150034) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "apps", force: :cascade do |t|
    t.string   "key"
    t.string   "identifier"
    t.string   "environment"
    t.string   "password"
    t.text     "certificate"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "devices", force: :cascade do |t|
    t.string   "identifier"
    t.string   "token"
    t.string   "app_id"
    t.datetime "last_access"
    t.float    "lat"
    t.float    "lon"
    t.string   "locale"
    t.string   "name"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "events", force: :cascade do |t|
    t.string   "type"
    t.string   "subtype"
    t.jsonb    "payload"
    t.datetime "timestamp"
    t.string   "uuid"
    t.integer  "user_id"
    t.string   "attachment"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "app_id"
  end

  create_table "messages", force: :cascade do |t|
    t.string   "receiver_id"
    t.integer  "sender_id"
    t.string   "category"
    t.string   "title"
    t.string   "question"
    t.string   "reply"
    t.boolean  "deleted"
    t.boolean  "sent"
    t.boolean  "received"
    t.boolean  "red"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.string   "url"
    t.integer  "badge"
    t.string   "sound"
    t.integer  "content_available"
    t.jsonb    "payload"
  end

  create_table "profiles", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "venue_id"
    t.integer  "role"
    t.text     "note"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "regions", force: :cascade do |t|
    t.string   "uuid"
    t.integer  "major"
    t.integer  "minor"
    t.float    "lat"
    t.float    "lon"
    t.float    "radius"
    t.integer  "venue_id"
    t.string   "name"
    t.text     "note"
    t.string   "identifier"
    t.integer  "enter_trigger_id"
    t.integer  "exit_trigger_id"
    t.integer  "range_trigger_id"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.integer  "behavior"
    t.integer  "type"
  end

  create_table "triggers", force: :cascade do |t|
    t.string   "url"
    t.string   "name"
    t.jsonb    "payload"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "type"
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "venues", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

end
