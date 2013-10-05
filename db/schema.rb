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

ActiveRecord::Schema.define(version: 20131004223723) do

  create_table "blogs", force: true do |t|
    t.integer  "user_id"
    t.string   "title"
    t.text     "content"
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.integer  "comment_count", default: 0
    t.string   "photo"
    t.string   "slug"
  end

  add_index "blogs", ["slug"], name: "index_blogs_on_slug", unique: true, using: :btree
  add_index "blogs", ["user_id", "created_at"], name: "index_blogs_on_user_id_and_created_at", using: :btree
  add_index "blogs", ["user_id"], name: "index_blogs_on_user_id", using: :btree

  create_table "captchas", force: true do |t|
    t.integer  "user_id"
    t.text     "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "captchas", ["user_id", "created_at"], name: "index_captchas_on_user_id_and_created_at", using: :btree
  add_index "captchas", ["user_id"], name: "index_captchas_on_user_id", using: :btree

  create_table "comments", force: true do |t|
    t.integer  "user_id"
    t.integer  "blog_id"
    t.text     "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "comments", ["blog_id"], name: "index_comments_on_blog_id", using: :btree
  add_index "comments", ["user_id", "blog_id"], name: "index_comments_on_user_id_and_blog_id", using: :btree
  add_index "comments", ["user_id"], name: "index_comments_on_user_id", using: :btree

  create_table "friendly_id_slugs", force: true do |t|
    t.string   "slug",                      null: false
    t.integer  "sluggable_id",              null: false
    t.string   "sluggable_type", limit: 50
    t.string   "scope"
    t.datetime "created_at"
  end

  add_index "friendly_id_slugs", ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true, using: :btree
  add_index "friendly_id_slugs", ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type", using: :btree
  add_index "friendly_id_slugs", ["sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_id", using: :btree
  add_index "friendly_id_slugs", ["sluggable_type"], name: "index_friendly_id_slugs_on_sluggable_type", using: :btree

  create_table "messages", force: true do |t|
    t.integer  "user_id"
    t.integer  "to_id"
    t.text     "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "messages", ["to_id", "created_at"], name: "index_messages_on_to_id_and_created_at", using: :btree
  add_index "messages", ["to_id"], name: "index_messages_on_to_id", using: :btree
  add_index "messages", ["user_id", "created_at"], name: "index_messages_on_user_id_and_created_at", using: :btree
  add_index "messages", ["user_id", "to_id", "created_at"], name: "index_messages_on_user_id_and_to_id_and_created_at", using: :btree
  add_index "messages", ["user_id", "to_id"], name: "index_messages_on_user_id_and_to_id", using: :btree
  add_index "messages", ["user_id"], name: "index_messages_on_user_id", using: :btree

  create_table "microposts", force: true do |t|
    t.text     "content"
    t.integer  "user_id"
    t.integer  "to_id"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.integer  "like_count", default: 0
  end

  add_index "microposts", ["to_id", "created_at"], name: "index_microposts_on_to_id_and_created_at", unique: true, using: :btree
  add_index "microposts", ["to_id"], name: "index_microposts_on_to_id", using: :btree
  add_index "microposts", ["user_id", "created_at"], name: "index_microposts_on_user_id_and_created_at", unique: true, using: :btree
  add_index "microposts", ["user_id", "to_id", "created_at"], name: "index_microposts_on_user_id_and_to_id_and_created_at", using: :btree
  add_index "microposts", ["user_id", "to_id"], name: "index_microposts_on_user_id_and_to_id", using: :btree

  create_table "opinions", force: true do |t|
    t.integer  "fan_id"
    t.integer  "like_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "opinions", ["fan_id", "like_id"], name: "index_opinions_on_fan_id_and_like_id", unique: true, using: :btree
  add_index "opinions", ["fan_id"], name: "index_opinions_on_fan_id", using: :btree
  add_index "opinions", ["like_id"], name: "index_opinions_on_like_id", using: :btree

  create_table "relationships", force: true do |t|
    t.integer  "follower_id"
    t.integer  "followed_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "relationships", ["followed_id"], name: "index_relationships_on_followed_id", using: :btree
  add_index "relationships", ["follower_id", "followed_id"], name: "index_relationships_on_follower_id_and_followed_id", unique: true, using: :btree
  add_index "relationships", ["follower_id"], name: "index_relationships_on_follower_id", using: :btree

  create_table "taggings", force: true do |t|
    t.integer  "blog_id"
    t.integer  "tag_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "taggings", ["blog_id", "tag_id"], name: "index_taggings_on_blog_id_and_tag_id", unique: true, using: :btree
  add_index "taggings", ["blog_id"], name: "index_taggings_on_blog_id", using: :btree
  add_index "taggings", ["tag_id"], name: "index_taggings_on_tag_id", using: :btree

  create_table "tags", force: true do |t|
    t.string   "name"
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.integer  "tagging_count", default: 0
    t.string   "slug"
  end

  add_index "tags", ["name"], name: "index_tags_on_name", using: :btree
  add_index "tags", ["slug"], name: "index_tags_on_slug", unique: true, using: :btree

  create_table "users", force: true do |t|
    t.string   "realname"
    t.string   "email"
    t.string   "name"
    t.string   "location"
    t.text     "bio"
    t.boolean  "admin",           default: false
    t.integer  "sign_in_count",   default: 0
    t.string   "password_digest"
    t.string   "remember_token"
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.string   "website"
    t.string   "slug"
  end

  add_index "users", ["created_at"], name: "index_users_on_created_at", using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["location"], name: "index_users_on_location", using: :btree
  add_index "users", ["name"], name: "index_users_on_name", unique: true, using: :btree
  add_index "users", ["realname", "name", "email"], name: "index_users_on_realname_and_name_and_email", unique: true, using: :btree
  add_index "users", ["realname", "name"], name: "index_users_on_realname_and_name", unique: true, using: :btree
  add_index "users", ["realname"], name: "index_users_on_realname", unique: true, using: :btree
  add_index "users", ["remember_token"], name: "index_users_on_remember_token", using: :btree
  add_index "users", ["sign_in_count"], name: "index_users_on_sign_in_count", using: :btree
  add_index "users", ["slug"], name: "index_users_on_slug", unique: true, using: :btree
  add_index "users", ["website"], name: "index_users_on_website", using: :btree

end
