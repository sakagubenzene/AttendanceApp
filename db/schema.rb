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

ActiveRecord::Schema[7.0].define(version: 2024_04_16_065556) do
  create_table "attendances", force: :cascade do |t|
    t.integer "user_id", null: false
    t.datetime "timestamp", null: false
    t.string "status", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_attendances_on_user_id"
  end

  create_table "messages", force: :cascade do |t|
    t.integer "attendance_id", null: false
    t.integer "attendance_to_change_id"
    t.integer "receiver_id", null: false
    t.text "content", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["attendance_id"], name: "index_messages_on_attendance_id"
    t.index ["attendance_to_change_id"], name: "index_messages_on_attendance_to_change_id"
    t.index ["receiver_id"], name: "index_messages_on_receiver_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "employee_number", null: false
    t.string "name", null: false
    t.string "password_digest", null: false
    t.boolean "admin", default: false, null: false
    t.string "remember_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "attendances", "users"
  add_foreign_key "messages", "attendances"
  add_foreign_key "messages", "attendances", column: "attendance_to_change_id"
  add_foreign_key "messages", "users", column: "receiver_id"
end
