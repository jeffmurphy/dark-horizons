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

ActiveRecord::Schema.define(version: 20151204203053) do

  create_table "notes", force: :cascade do |t|
    t.string   "domain"
    t.datetime "posted_at"
    t.string   "notetype"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "statuses", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",            null: false
    t.string   "crypted_password"
    t.string   "salt"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true

  create_table "watchers", force: :cascade do |t|
    t.string   "apiurl"
    t.string   "apikey"
    t.string   "username"
    t.string   "password"
    t.string   "domain"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "okimg"
    t.string   "nokimg"
    t.integer  "user_id"
  end

  add_index "watchers", ["user_id"], name: "index_watchers_on_user_id"

end
