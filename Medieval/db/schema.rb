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

ActiveRecord::Schema[7.1].define(version: 2023_11_13_161035) do
  create_table "answers", force: :cascade do |t|
    t.integer "enigme_id", null: false
    t.boolean "true"
    t.text "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["enigme_id"], name: "index_answers_on_enigme_id"
  end

  create_table "articles", force: :cascade do |t|
    t.string "title"
    t.text "body"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "enigmes", force: :cascade do |t|
    t.text "titre"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "hdvs", force: :cascade do |t|
    t.integer "item_id", null: false
    t.integer "player_id", null: false
    t.integer "price"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["item_id"], name: "index_hdvs_on_item_id"
    t.index ["player_id"], name: "index_hdvs_on_player_id"
  end

  create_table "inventories", force: :cascade do |t|
    t.integer "player_id", null: false
    t.integer "item_id", null: false
    t.boolean "active"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["item_id"], name: "index_inventories_on_item_id"
    t.index ["player_id"], name: "index_inventories_on_player_id"
  end

  create_table "items", force: :cascade do |t|
    t.string "name"
    t.string "image"
    t.string "category"
    t.integer "pv"
    t.integer "force"
    t.integer "xp"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "levels", force: :cascade do |t|
    t.integer "level"
    t.integer "xp_total"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "masters", force: :cascade do |t|
    t.string "username"
    t.string "password"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "monsters", force: :cascade do |t|
    t.integer "force"
    t.integer "pv"
    t.string "avatar"
    t.integer "item_id", null: false
    t.integer "rate"
    t.string "name"
    t.boolean "active"
    t.text "message"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["item_id"], name: "index_monsters_on_item_id"
  end

  create_table "players", force: :cascade do |t|
    t.integer "xp"
    t.integer "pv"
    t.integer "force"
    t.string "name"
    t.string "avatar"
    t.integer "po"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "quests", force: :cascade do |t|
    t.string "title"
    t.integer "xp"
    t.integer "item_id", null: false
    t.bigint "player_id"
    t.integer "master_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["item_id"], name: "index_quests_on_item_id"
    t.index ["master_id"], name: "index_quests_on_master_id"
    t.index ["player_id"], name: "index_quests_on_player_id"
  end

  create_table "steps", force: :cascade do |t|
    t.integer "quest_id", null: false
    t.integer "monster_id", null: false
    t.integer "enigme_id", null: false
    t.integer "xp"
    t.string "titre"
    t.integer "player_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["enigme_id"], name: "index_steps_on_enigme_id"
    t.index ["monster_id"], name: "index_steps_on_monster_id"
    t.index ["player_id"], name: "index_steps_on_player_id"
    t.index ["quest_id"], name: "index_steps_on_quest_id"
  end

  add_foreign_key "answers", "enigmes"
  add_foreign_key "hdvs", "items"
  add_foreign_key "hdvs", "players"
  add_foreign_key "inventories", "items"
  add_foreign_key "inventories", "players"
  add_foreign_key "monsters", "items"
  add_foreign_key "quests", "items"
  add_foreign_key "quests", "masters"
  add_foreign_key "quests", "players"
  add_foreign_key "steps", "enigmes"
  add_foreign_key "steps", "monsters"
  add_foreign_key "steps", "players"
  add_foreign_key "steps", "quests"
end
