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

ActiveRecord::Schema[7.0].define(version: 2023_05_16_153521) do
  create_table "departments", force: :cascade do |t|
    t.string "name"
    t.string "abbreviation"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "employees", force: :cascade do |t|
    t.string "last_name"
    t.string "first_name"
    t.string "middle_name"
    t.string "passport_data"
    t.date "date_of_birth"
    t.string "place_of_birth"
    t.string "home_address"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "department_id"
    t.index ["department_id"], name: "index_employees_on_department_id"
  end

  create_table "position_histories", force: :cascade do |t|
    t.date "started_on"
    t.date "finished_on"
    t.integer "employee_id"
    t.integer "position_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["employee_id"], name: "index_position_histories_on_employee_id"
    t.index ["position_id"], name: "index_position_histories_on_position_id"
  end

  create_table "positions", force: :cascade do |t|
    t.string "name"
    t.integer "salary"
    t.integer "vacation_days"
  end

  create_table "vacations", force: :cascade do |t|
    t.date "started_on"
    t.date "finished_on"
    t.integer "employee_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["employee_id"], name: "index_vacations_on_employee_id"
  end

end
