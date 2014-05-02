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

ActiveRecord::Schema.define(version: 20140502002813) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "comments", force: true do |t|
    t.text     "body",              null: false
    t.integer  "author_id",         null: false
    t.integer  "link_id",           null: false
    t.integer  "parent_comment_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "comments", ["author_id"], name: "index_comments_on_author_id", using: :btree
  add_index "comments", ["link_id"], name: "index_comments_on_link_id", using: :btree
  add_index "comments", ["parent_comment_id"], name: "index_comments_on_parent_comment_id", using: :btree

  create_table "link_subs", force: true do |t|
    t.integer  "link_id",    null: false
    t.integer  "sub_id",     null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "link_subs", ["link_id", "sub_id"], name: "index_link_subs_on_link_id_and_sub_id", unique: true, using: :btree
  add_index "link_subs", ["link_id"], name: "index_link_subs_on_link_id", using: :btree
  add_index "link_subs", ["sub_id"], name: "index_link_subs_on_sub_id", using: :btree

  create_table "links", force: true do |t|
    t.string   "title",        null: false
    t.string   "url",          null: false
    t.text     "text"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "submitter_id"
  end

  create_table "subs", force: true do |t|
    t.string   "name",         null: false
    t.integer  "moderator_id", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "subs", ["moderator_id"], name: "index_subs_on_moderator_id", using: :btree
  add_index "subs", ["name"], name: "index_subs_on_name", unique: true, using: :btree

  create_table "user_votes", force: true do |t|
    t.integer  "user_id",    null: false
    t.integer  "link_id",    null: false
    t.boolean  "upvote",     null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "user_votes", ["link_id"], name: "index_user_votes_on_link_id", using: :btree
  add_index "user_votes", ["user_id", "link_id"], name: "index_user_votes_on_user_id_and_link_id", unique: true, using: :btree
  add_index "user_votes", ["user_id"], name: "index_user_votes_on_user_id", using: :btree

  create_table "users", force: true do |t|
    t.string   "username",        null: false
    t.string   "password_digest", null: false
    t.string   "session_token",   null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
