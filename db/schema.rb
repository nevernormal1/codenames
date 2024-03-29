# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_03_29_200751) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "boards", force: :cascade do |t|
    t.string "giver_link_token"
    t.string "guesser_link_token"
    t.text "words"
    t.integer "assassin"
    t.text "blue"
    t.text "red"
    t.integer "turn"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["giver_link_token"], name: "index_boards_on_giver_link_token", unique: true
    t.index ["guesser_link_token"], name: "index_boards_on_guesser_link_token", unique: true
  end

  create_table "clues", force: :cascade do |t|
    t.bigint "board_id"
    t.string "clue"
    t.integer "number"
    t.integer "turn"
    t.index ["board_id"], name: "index_clues_on_board_id"
  end

  create_table "guesses", force: :cascade do |t|
    t.bigint "board_id"
    t.string "guess"
    t.integer "turn"
    t.index ["board_id"], name: "index_guesses_on_board_id"
  end

  create_table "words", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "value"
  end

end
