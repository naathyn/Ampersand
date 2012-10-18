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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20121018024357) do

  create_table "hash_tags", :force => true do |t|
    t.integer  "micropost_id"
    t.integer  "tag_id"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  add_index "hash_tags", ["micropost_id", "tag_id"], :name => "index_hash_tags_on_micropost_id_and_tag_id"

  create_table "messages", :force => true do |t|
    t.string   "convo"
    t.integer  "user_id"
    t.integer  "to_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "messages", ["to_id"], :name => "index_messages_on_to_id"
  add_index "messages", ["user_id", "created_at"], :name => "index_messages_on_user_id_and_created_at"
  add_index "messages", ["user_id"], :name => "index_messages_on_user_id"

  create_table "microposts", :force => true do |t|
    t.string   "content"
    t.integer  "user_id"
    t.integer  "to_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "microposts", ["user_id", "created_at"], :name => "index_microposts_on_user_id_and_created_at"

  create_table "opinions", :force => true do |t|
    t.integer  "fan_id"
    t.integer  "like_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "opinions", ["fan_id", "like_id"], :name => "index_opinions_on_fan_id_and_like_id", :unique => true
  add_index "opinions", ["fan_id"], :name => "index_opinions_on_fan_id"
  add_index "opinions", ["like_id"], :name => "index_opinions_on_like_id"

  create_table "relationships", :force => true do |t|
    t.integer  "follower_id"
    t.integer  "followed_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "relationships", ["followed_id"], :name => "index_relationships_on_followed_id"
  add_index "relationships", ["follower_id", "followed_id"], :name => "index_relationships_on_follower_id_and_followed_id", :unique => true
  add_index "relationships", ["follower_id"], :name => "index_relationships_on_follower_id"

  create_table "tags", :force => true do |t|
    t.string   "word"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "tags", ["word"], :name => "index_tags_on_word"

  create_table "users", :force => true do |t|
    t.string   "realname"
    t.string   "email"
    t.string   "name"
    t.string   "location"
    t.string   "bio"
    t.string   "password_digest"
    t.string   "remember_token"
    t.boolean  "admin",           :default => false
    t.datetime "created_at",                         :null => false
    t.datetime "updated_at",                         :null => false
  end

  add_index "users", ["bio"], :name => "index_users_on_bio"
  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["location"], :name => "index_users_on_location"
  add_index "users", ["name"], :name => "index_users_on_name", :unique => true
  add_index "users", ["realname"], :name => "index_users_on_realname", :unique => true
  add_index "users", ["remember_token"], :name => "index_users_on_remember_token"

  create_table "versions", :force => true do |t|
    t.string   "item_type",  :null => false
    t.integer  "item_id",    :null => false
    t.string   "event",      :null => false
    t.string   "whodunnit"
    t.text     "object"
    t.datetime "created_at"
  end

  add_index "versions", ["item_type", "item_id"], :name => "index_versions_on_item_type_and_item_id"

end
