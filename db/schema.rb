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

ActiveRecord::Schema[7.0].define(version: 2023_06_03_194547) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "assign_tickets", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "ticket_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["ticket_id"], name: "index_assign_tickets_on_ticket_id"
    t.index ["user_id"], name: "index_assign_tickets_on_user_id"
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
    t.datetime "creation_date", default: "2023-06-03 19:32:20", null: false
    t.datetime "resolution_date", default: "2023-06-03 19:32:20", null: false
    t.datetime "response_to_user_date", default: "2023-06-03 19:32:20", null: false
    t.integer "priority", default: 0, null: false
    t.integer "state", default: 0, null: false
    t.integer "resolution_key", default: 0, null: false
    t.integer "response_key", default: 0, null: false
    t.text "response_to_user", default: " ", null: false
    t.integer "accept_or_reject_solution", default: 0, null: false
    t.integer "star_number", default: 0, null: false
    t.datetime "limit_time_response", default: "2023-06-03 19:32:20", null: false
    t.datetime "limit_time_resolution", default: "2023-06-03 19:32:20", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "name", null: false
    t.string "last_name", null: false
    t.string "phone", null: false
    t.integer "profile", default: 0, null: false
    t.string "mail", null: false
    t.text "password", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "assign_tickets", "tickets"
  add_foreign_key "assign_tickets", "users"
  add_foreign_key "ticket_lists", "tickets"
  add_foreign_key "ticket_lists", "users"
end
