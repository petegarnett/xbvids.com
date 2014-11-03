# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20141103100929) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "games", force: true do |t|
    t.string   "xgid"
    t.string   "name"
    t.text     "description"
    t.string   "developer"
    t.string   "image_box"
    t.string   "image_hero_title"
    t.string   "image_hero_super"
    t.integer  "rating"
    t.string   "title_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "image_poster"
  end

  add_index "games", ["xgid"], name: "index_games_on_xgid", using: :btree

  create_table "users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "gamertag"
    t.string   "xuid"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["gamertag"], name: "index_users_on_gamertag", using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["xuid"], name: "index_users_on_xuid", using: :btree

  create_table "videos", force: true do |t|
    t.string   "clip_id"
    t.datetime "recorded_at"
    t.string   "clip_type"
    t.string   "thumbnail_large"
    t.text     "source_uri"
    t.string   "title"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.boolean  "is_thumbnail_uploaded"
    t.boolean  "is_clip_uploaded"
    t.integer  "game_id"
    t.integer  "like_count",                    default: 0
    t.string   "caption"
    t.integer  "view_count",                    default: 0
    t.integer  "transcoded_notification_count", default: 0
  end

  add_index "videos", ["clip_id"], name: "index_videos_on_clip_id", unique: true, using: :btree
  add_index "videos", ["game_id"], name: "index_videos_on_game_id", using: :btree
  add_index "videos", ["user_id"], name: "index_videos_on_user_id", using: :btree

end
