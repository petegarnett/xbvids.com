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

ActiveRecord::Schema.define(version: 20150705124617) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "games", force: :cascade do |t|
    t.string   "xgid",             limit: 255
    t.string   "name",             limit: 255
    t.text     "description"
    t.string   "developer",        limit: 255
    t.string   "image_box",        limit: 255
    t.string   "image_hero_title", limit: 255
    t.string   "image_hero_super", limit: 255
    t.integer  "rating"
    t.string   "title_id",         limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "games", ["xgid"], name: "index_games_on_xgid", using: :btree

  create_table "screenshots", force: :cascade do |t|
    t.integer  "game_id"
    t.integer  "user_id"
    t.string   "xuid",               limit: 255
    t.text     "url"
    t.integer  "width"
    t.integer  "height"
    t.text     "thumbnail_small"
    t.text     "thumbnail_large"
    t.datetime "date_taken"
    t.string   "screenshot_type",    limit: 255
    t.boolean  "saved_by_user"
    t.integer  "achievement_id"
    t.integer  "greatest_moment_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "is_uploaded",                    default: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  limit: 255, default: "", null: false
    t.string   "encrypted_password",     limit: 255, default: "", null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                      default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "gamertag",               limit: 255
    t.string   "xuid",                   limit: 255
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["gamertag"], name: "index_users_on_gamertag", using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["xuid"], name: "index_users_on_xuid", using: :btree

  create_table "videos", force: :cascade do |t|
    t.string   "clip_id",                       limit: 255
    t.datetime "recorded_at"
    t.string   "clip_type",                     limit: 255
    t.string   "thumbnail_large",               limit: 255
    t.text     "source_uri"
    t.string   "title",                         limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.boolean  "is_thumbnail_uploaded",                     default: false
    t.boolean  "is_clip_uploaded",                          default: false
    t.integer  "game_id"
    t.integer  "like_count",                                default: 0
    t.string   "caption",                       limit: 255
    t.integer  "view_count",                                default: 0
    t.integer  "transcoded_notification_count",             default: 0
    t.integer  "mlg_count",                                 default: 0
    t.integer  "wtf_count",                                 default: 0
    t.integer  "lol_count",                                 default: 0
  end

  add_index "videos", ["clip_id"], name: "index_videos_on_clip_id", unique: true, using: :btree
  add_index "videos", ["game_id"], name: "index_videos_on_game_id", using: :btree
  add_index "videos", ["user_id"], name: "index_videos_on_user_id", using: :btree

end
