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

ActiveRecord::Schema.define(:version => 20120524234108) do

  create_table "microposts", :force => true do |t|
    t.string   "content"
    t.integer  "user_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "from_id"
  end

  add_index "microposts", ["created_at"], :name => "index_microposts_on_created_at"
  add_index "microposts", ["user_id"], :name => "index_microposts_on_user_id"

  create_table "relationships", :force => true do |t|
    t.integer  "user_friend_id"
    t.integer  "friend_id"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  add_index "relationships", ["friend_id"], :name => "index_relationships_on_friend_id"
  add_index "relationships", ["user_friend_id", "friend_id"], :name => "index_relationships_on_user_friend_id_and_friend_id", :unique => true
  add_index "relationships", ["user_friend_id"], :name => "index_relationships_on_user_friend_id"

  create_table "requests", :force => true do |t|
    t.integer  "user_id"
    t.integer  "user_from_id"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  add_index "requests", ["user_from_id"], :name => "index_requests_on_user_from_id"
  add_index "requests", ["user_id"], :name => "index_requests_on_user_id"

  create_table "users", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at",                            :null => false
    t.datetime "updated_at",                            :null => false
    t.string   "encrypted_password"
    t.string   "salt"
    t.boolean  "admin",              :default => false
    t.date     "data_of_burn"
    t.string   "phone"
    t.string   "city"
    t.text     "about"
    t.string   "status"
    t.boolean  "blocked",            :default => false
    t.string   "sex"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true

end
