# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2023_06_08_133253) do
  # These are extensions that must be enabled in order to support this database
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
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "assign_tickets", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "ticket_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["ticket_id"], name: "index_assign_tickets_on_ticket_id"
    t.index ["user_id"], name: "index_assign_tickets_on_user_id"
  end

  create_table "chats", force: :cascade do |t|
    t.bigint "ticket_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["ticket_id"], name: "index_chats_on_ticket_id"
  end

  create_table "comments", force: :cascade do |t|
    t.text "text", null: false
    t.string "writer", null: false
    t.bigint "chat_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["chat_id"], name: "index_comments_on_chat_id"
  end

  create_table "performance_reports", force: :cascade do |t|
    t.datetime "report_date", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_performance_reports_on_user_id"
  end

  create_table "tag_lists", force: :cascade do |t|
    t.bigint "ticket_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["ticket_id"], name: "index_tag_lists_on_ticket_id"
  end

  create_table "tags", force: :cascade do |t|
    t.string "name", null: false
    t.bigint "tag_list_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["tag_list_id"], name: "index_tags_on_tag_list_id"
  end

  create_table "ticket_lists", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "ticket_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["ticket_id"], name: "index_ticket_lists_on_ticket_id"
    t.index ["user_id"], name: "index_ticket_lists_on_user_id"
  end

  create_table "tickets", force: :cascade do |t|
    t.string "title", null: false
    t.text "incident_description", null: false
    t.datetime "creation_date", default: "2023-06-20 00:17:09", null: false
    t.datetime "resolution_date", default: "2023-06-20 00:17:09", null: false
    t.datetime "response_to_user_date", default: "2023-06-20 00:17:09", null: false
    t.integer "priority", default: 0, null: false
    t.integer "state", default: 0, null: false
    t.integer "resolution_key", default: 0, null: false
    t.integer "response_key", default: 0, null: false
    t.text "response_to_user", default: "", null: false
    t.integer "accept_or_reject_solution", default: 0, null: false
    t.integer "star_number", default: 6, null: false
    t.datetime "limit_time_response", default: "2023-06-20 00:17:09", null: false
    t.datetime "limit_time_resolution", default: "2023-06-20 00:17:09", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "name", null: false
    t.string "last_name", null: false
    t.string "phone", null: false
    t.integer "profile", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "assign_tickets", "tickets"
  add_foreign_key "assign_tickets", "users"
  add_foreign_key "chats", "tickets"
  add_foreign_key "comments", "chats"
  add_foreign_key "performance_reports", "users"
  add_foreign_key "tag_lists", "tickets"
  add_foreign_key "tags", "tag_lists"
  add_foreign_key "ticket_lists", "tickets"
  add_foreign_key "ticket_lists", "users"
end
