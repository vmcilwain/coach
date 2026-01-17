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

ActiveRecord::Schema[8.1].define(version: 2026_01_11_164422) do
  create_table "goals", force: :cascade do |t|
    t.decimal "body_fat_percent", precision: 5, scale: 2, default: "0.0", null: false
    t.integer "calories"
    t.integer "carbs"
    t.datetime "created_at", null: false
    t.decimal "fat_mass", precision: 5, scale: 2, default: "0.0", null: false
    t.integer "fats"
    t.integer "protein"
    t.datetime "updated_at", null: false
    t.decimal "weight", precision: 5, scale: 2, default: "0.0", null: false
  end

  create_table "meals", force: :cascade do |t|
    t.integer "calories", default: 0, null: false
    t.integer "carbs", default: 0, null: false
    t.datetime "created_at", null: false
    t.integer "fats", default: 0, null: false
    t.string "item", default: "", null: false
    t.integer "protein", default: 0, null: false
    t.datetime "updated_at", null: false
  end

  create_table "weights", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.decimal "fat_mass", precision: 5, scale: 2, default: "0.0", null: false
    t.decimal "fat_percentage"
    t.decimal "muscle_mass"
    t.decimal "muscle_percentage"
    t.datetime "updated_at", null: false
    t.decimal "weight", precision: 5, scale: 2, default: "0.0", null: false
  end
end
