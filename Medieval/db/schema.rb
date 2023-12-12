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

ActiveRecord::Schema[7.1].define(version: 2023_12_11_135039) do
  create_table "answers", force: :cascade do |t|
    t.integer "enigme_id", null: false
    t.text "true"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "reponse_1"
    t.text "reponse_2"
    t.text "reponse_3"
    t.index ["enigme_id"], name: "index_answers_on_enigme_id"
  end

  create_table "articles", force: :cascade do |t|
    t.string "title"
    t.text "body"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "characters", force: :cascade do |t|
    t.string "name"
    t.integer "player_id", null: false
    t.string "avatar"
    t.integer "xp"
    t.integer "force"
    t.integer "pv"
    t.integer "po"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "level"
    t.integer "quest_id"
    t.index ["player_id"], name: "index_characters_on_player_id"
    t.index ["quest_id"], name: "index_characters_on_quest_id"
  end

  create_table "enigmes", force: :cascade do |t|
    t.text "titre"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "hdvs", force: :cascade do |t|
    t.integer "item_id", null: false
    t.integer "price"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "character_id", null: false
    t.index ["character_id"], name: "index_hdvs_on_character_id"
    t.index ["item_id"], name: "index_hdvs_on_item_id"
  end

  create_table "inventories", force: :cascade do |t|
    t.integer "item_id", null: false
    t.boolean "active"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "character_id", null: false
    t.index ["character_id"], name: "index_inventories_on_character_id"
    t.index ["item_id"], name: "index_inventories_on_item_id"
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
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "monsters", force: :cascade do |t|
    t.integer "force"
    t.integer "pv"
    t.string "avatar"
    t.bigint "item_id"
    t.integer "rate"
    t.string "name"
    t.boolean "active"
    t.text "message"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["item_id"], name: "index_monsters_on_item_id"
  end

  create_table "players", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "password"
    t.string "password_digest"
  end

  create_table "quests", force: :cascade do |t|
    t.string "title"
    t.integer "xp"
    t.integer "item_id", null: false
    t.integer "master_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "character_id"
    t.integer "level"
    t.index ["character_id"], name: "index_quests_on_character_id"
    t.index ["item_id"], name: "index_quests_on_item_id"
    t.index ["master_id"], name: "index_quests_on_master_id"
  end

  create_table "steps", force: :cascade do |t|
    t.integer "quest_id", null: false
    t.bigint "monster_id"
    t.bigint "enigme_id"
    t.integer "xp"
    t.string "titre"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "character_id"
    t.bigint "player_id"
    t.index ["character_id"], name: "index_steps_on_character_id"
    t.index ["enigme_id"], name: "index_steps_on_enigme_id"
    t.index ["monster_id"], name: "index_steps_on_monster_id"
    t.index ["quest_id"], name: "index_steps_on_quest_id"
  end

  add_foreign_key "answers", "enigmes"
  add_foreign_key "characters", "players"
  add_foreign_key "characters", "quests"
  add_foreign_key "hdvs", "characters"
  add_foreign_key "hdvs", "items"
  add_foreign_key "inventories", "characters"
  add_foreign_key "inventories", "items"
  add_foreign_key "monsters", "items"
  add_foreign_key "quests", "characters"
  add_foreign_key "quests", "items"
  add_foreign_key "quests", "masters"
  add_foreign_key "steps", "characters"
  add_foreign_key "steps", "enigmes"
  add_foreign_key "steps", "monsters"
  add_foreign_key "steps", "quests"
end
