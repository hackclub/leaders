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

ActiveRecord::Schema.define(version: 2018_09_11_042246) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "change_requests", force: :cascade do |t|
    t.datetime "pr_opened_at"
    t.datetime "pr_merged_at"
    t.datetime "pr_closed_at"
    t.string "pr_url"
    t.bigint "user_id"
    t.bigint "subdomain_id"
    t.string "value"
    t.integer "type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["subdomain_id"], name: "index_change_requests_on_subdomain_id"
    t.index ["user_id"], name: "index_change_requests_on_user_id"
  end

  create_table "subdomains", force: :cascade do |t|
    t.integer "club_id"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.integer "api_id"
    t.text "api_access_token"
    t.text "session_token"
    t.text "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["api_access_token"], name: "index_users_on_api_access_token", unique: true
    t.index ["api_id"], name: "index_users_on_api_id", unique: true
  end

  add_foreign_key "change_requests", "subdomains"
  add_foreign_key "change_requests", "users"
end
