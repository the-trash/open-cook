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

ActiveRecord::Schema.define(version: 20130111160148) do

  create_table "posts", force: true do |t|
    t.integer  "user_id"
    t.string   "short_id",           default: "",      null: false
    t.string   "slug_id",            default: "",      null: false
    t.string   "friendly_id",        default: "",      null: false
    t.string   "author"
    t.string   "keywords"
    t.string   "description"
    t.string   "copyright"
    t.string   "title"
    t.text     "raw_intro"
    t.text     "raw_content"
    t.text     "intro"
    t.text     "content"
    t.string   "main_image_url"
    t.integer  "show_count",         default: 0
    t.string   "state",              default: "draft"
    t.integer  "parent_id"
    t.integer  "lft"
    t.integer  "rgt"
    t.integer  "depth",              default: 0
    t.integer  "files_count",        default: 0
    t.integer  "files_size",         default: 0
    t.datetime "first_published_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
