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

ActiveRecord::Schema.define(version: 2018_11_20_052204) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "hstore"
  enable_extension "plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "change_requests", force: :cascade do |t|
    t.bigint "pull_request_id"
    t.bigint "dns_record_id"
    t.hstore "changes_hash"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["dns_record_id"], name: "index_change_requests_on_dns_record_id"
    t.index ["pull_request_id"], name: "index_change_requests_on_pull_request_id"
  end

  create_table "clubs", force: :cascade do |t|
    t.integer "api_id"
    t.string "name"
    t.string "slug"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.jsonb "api_record"
  end

  create_table "clubs_users", id: false, force: :cascade do |t|
    t.bigint "club_id", null: false
    t.bigint "user_id", null: false
  end

  create_table "dns_records", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "subdomain_id"
    t.string "value"
    t.integer "record_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "deleted_at"
    t.index ["subdomain_id"], name: "index_dns_records_on_subdomain_id"
    t.index ["user_id"], name: "index_dns_records_on_user_id"
  end

  create_table "meetings", force: :cascade do |t|
    t.datetime "start_time"
    t.integer "attendee_count"
    t.bigint "club_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["club_id"], name: "index_meetings_on_club_id"
  end

  create_table "posts", force: :cascade do |t|
    t.text "name"
    t.text "url"
    t.bigint "club_id"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["club_id"], name: "index_posts_on_club_id"
    t.index ["user_id"], name: "index_posts_on_user_id"
  end

  create_table "pull_requests", force: :cascade do |t|
    t.string "repo"
    t.integer "number"
    t.bigint "subdomain_id"
    t.datetime "closed_at"
    t.datetime "merged_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["subdomain_id"], name: "index_pull_requests_on_subdomain_id"
  end

  create_table "subdomains", force: :cascade do |t|
    t.integer "club_id"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "deleted_at"
  end

  create_table "users", force: :cascade do |t|
    t.integer "api_id"
    t.text "api_access_token"
    t.text "session_token"
    t.text "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "email_on_check_in", default: false, null: false
    t.index ["api_access_token"], name: "index_users_on_api_access_token", unique: true
    t.index ["api_id"], name: "index_users_on_api_id", unique: true
  end

  add_foreign_key "dns_records", "subdomains"
  add_foreign_key "dns_records", "users"
  add_foreign_key "meetings", "clubs"
  add_foreign_key "posts", "clubs"
  add_foreign_key "posts", "users"
end
