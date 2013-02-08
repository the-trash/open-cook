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

ActiveRecord::Schema.define(version: 20130207055426) do

  create_table "articles", force: true do |t|
    t.integer  "user_id"
    t.integer  "hub_id"
    t.string   "author"
    t.string   "keywords"
    t.string   "description"
    t.string   "copyright"
    t.string   "title"
    t.text     "raw_intro"
    t.text     "raw_content"
    t.text     "intro"
    t.text     "content"
    t.string   "legacy_url"
    t.datetime "first_published_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "parent_id"
    t.integer  "lft"
    t.integer  "rgt"
    t.integer  "depth",              default: 0
    t.string   "main_image_url"
    t.integer  "show_count",         default: 0
    t.string   "state",              default: "draft"
    t.string   "moderation_state",   default: "unmoderated"
    t.text     "moderator_note"
    t.integer  "files_count",        default: 0
    t.integer  "files_size",         default: 0
    t.string   "short_id"
    t.string   "friendly_id"
    t.integer  "comments_count",     default: 0
  end

  create_table "audits", force: true do |t|
    t.integer  "user_id"
    t.string   "obj_id"
    t.string   "obj_type"
    t.string   "controller_name"
    t.string   "action_name"
    t.string   "ip"
    t.string   "remote_ip"
    t.string   "fullpath"
    t.string   "referer"
    t.string   "user_agent"
    t.string   "remote_addr"
    t.string   "remote_host"
    t.text     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "blogs", force: true do |t|
    t.integer  "user_id"
    t.integer  "hub_id"
    t.string   "author"
    t.string   "keywords"
    t.string   "description"
    t.string   "copyright"
    t.string   "title"
    t.text     "raw_intro"
    t.text     "raw_content"
    t.text     "intro"
    t.text     "content"
    t.string   "legacy_url"
    t.datetime "first_published_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "parent_id"
    t.integer  "lft"
    t.integer  "rgt"
    t.integer  "depth",              default: 0
    t.string   "main_image_url"
    t.integer  "show_count",         default: 0
    t.string   "state",              default: "draft"
    t.string   "moderation_state",   default: "unmoderated"
    t.text     "moderator_note"
    t.integer  "files_count",        default: 0
    t.integer  "files_size",         default: 0
    t.string   "short_id"
    t.string   "friendly_id"
    t.integer  "comments_count",     default: 0
  end

  create_table "comments", force: true do |t|
    t.integer  "user_id"
    t.integer  "commentable_id"
    t.string   "commentable_type"
    t.string   "title"
    t.string   "contacts"
    t.text     "raw_content"
    t.text     "content"
    t.string   "state",            default: "not_approved"
    t.string   "ip"
    t.string   "referer"
    t.string   "user_agent"
    t.integer  "parent_id"
    t.integer  "lft"
    t.integer  "rgt"
    t.integer  "depth",            default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "hubs", force: true do |t|
    t.integer  "user_id"
    t.integer  "hub_id"
    t.string   "author"
    t.string   "keywords"
    t.string   "description"
    t.string   "copyright"
    t.string   "title"
    t.text     "raw_intro"
    t.text     "raw_content"
    t.text     "intro"
    t.text     "content"
    t.string   "legacy_url"
    t.datetime "first_published_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "hub_type"
    t.integer  "parent_id"
    t.integer  "lft"
    t.integer  "rgt"
    t.integer  "depth",              default: 0
    t.string   "main_image_url"
    t.integer  "show_count",         default: 0
    t.string   "state",              default: "draft"
    t.string   "moderation_state",   default: "unmoderated"
    t.text     "moderator_note"
    t.integer  "files_count",        default: 0
    t.integer  "files_size",         default: 0
    t.string   "short_id"
    t.string   "friendly_id"
  end

  create_table "notes", force: true do |t|
    t.integer  "user_id"
    t.integer  "hub_id"
    t.string   "author"
    t.string   "keywords"
    t.string   "description"
    t.string   "copyright"
    t.string   "title"
    t.text     "raw_intro"
    t.text     "raw_content"
    t.text     "intro"
    t.text     "content"
    t.string   "legacy_url"
    t.datetime "first_published_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "parent_id"
    t.integer  "lft"
    t.integer  "rgt"
    t.integer  "depth",              default: 0
    t.string   "main_image_url"
    t.integer  "show_count",         default: 0
    t.string   "state",              default: "draft"
    t.string   "moderation_state",   default: "unmoderated"
    t.text     "moderator_note"
    t.integer  "files_count",        default: 0
    t.integer  "files_size",         default: 0
    t.string   "short_id"
    t.string   "friendly_id"
    t.integer  "comments_count",     default: 0
  end

  create_table "pages", force: true do |t|
    t.integer  "user_id"
    t.integer  "hub_id"
    t.string   "author"
    t.string   "keywords"
    t.string   "description"
    t.string   "copyright"
    t.string   "title"
    t.text     "raw_intro"
    t.text     "raw_content"
    t.text     "intro"
    t.text     "content"
    t.string   "legacy_url"
    t.datetime "first_published_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "parent_id"
    t.integer  "lft"
    t.integer  "rgt"
    t.integer  "depth",              default: 0
    t.string   "main_image_url"
    t.integer  "show_count",         default: 0
    t.string   "state",              default: "draft"
    t.string   "moderation_state",   default: "unmoderated"
    t.text     "moderator_note"
    t.integer  "files_count",        default: 0
    t.integer  "files_size",         default: 0
    t.string   "short_id"
    t.string   "friendly_id"
    t.integer  "comments_count",     default: 0
  end

  create_table "posts", force: true do |t|
    t.integer  "user_id"
    t.integer  "hub_id"
    t.string   "author"
    t.string   "keywords"
    t.string   "description"
    t.string   "copyright"
    t.string   "title"
    t.text     "raw_intro"
    t.text     "raw_content"
    t.text     "intro"
    t.text     "content"
    t.string   "legacy_url"
    t.datetime "first_published_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "parent_id"
    t.integer  "lft"
    t.integer  "rgt"
    t.integer  "depth",              default: 0
    t.string   "main_image_url"
    t.integer  "show_count",         default: 0
    t.string   "state",              default: "draft"
    t.string   "moderation_state",   default: "unmoderated"
    t.text     "moderator_note"
    t.integer  "files_count",        default: 0
    t.integer  "files_size",         default: 0
    t.string   "short_id"
    t.string   "friendly_id"
    t.integer  "comments_count",     default: 0
  end

  create_table "recipes", force: true do |t|
    t.integer  "user_id"
    t.integer  "hub_id"
    t.string   "author"
    t.string   "keywords"
    t.string   "description"
    t.string   "copyright"
    t.string   "title"
    t.text     "raw_intro"
    t.text     "raw_content"
    t.text     "intro"
    t.text     "content"
    t.string   "legacy_url"
    t.datetime "first_published_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "parent_id"
    t.integer  "lft"
    t.integer  "rgt"
    t.integer  "depth",              default: 0
    t.string   "main_image_url"
    t.integer  "show_count",         default: 0
    t.string   "state",              default: "draft"
    t.string   "moderation_state",   default: "unmoderated"
    t.text     "moderator_note"
    t.integer  "files_count",        default: 0
    t.integer  "files_size",         default: 0
    t.string   "short_id"
    t.string   "friendly_id"
    t.integer  "comments_count",     default: 0
  end

  create_table "roles", force: true do |t|
    t.string   "name",        null: false
    t.string   "title",       null: false
    t.text     "description", null: false
    t.text     "the_role",    null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "login",                                              null: false
    t.string   "username"
    t.string   "email"
    t.string   "open_password"
    t.string   "crypted_password"
    t.string   "salt"
    t.integer  "role_id"
    t.integer  "show_count",                      default: 0
    t.string   "state",                           default: "active"
    t.integer  "hubs_count",                      default: 0
    t.integer  "pages_count",                     default: 0
    t.integer  "posts_count",                     default: 0
    t.integer  "blogs_count",                     default: 0
    t.integer  "notes_count",                     default: 0
    t.integer  "recipes_count",                   default: 0
    t.integer  "articles_count",                  default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "remember_me_token"
    t.datetime "remember_me_token_expires_at"
    t.string   "reset_password_token"
    t.datetime "reset_password_token_expires_at"
    t.datetime "reset_password_email_sent_at"
    t.integer  "total_files_count",               default: 0
    t.integer  "total_files_size",                default: 0
    t.integer  "files_count",                     default: 0
    t.integer  "files_size",                      default: 0
    t.integer  "created_comments_count",          default: 0
    t.integer  "approved_comments_count",         default: 0
    t.integer  "not_approved_comments_count",     default: 0
    t.integer  "comments_count",                  default: 0
  end

  add_index "users", ["remember_me_token"], name: "index_users_on_remember_me_token"
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token"

end
