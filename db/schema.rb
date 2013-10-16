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

ActiveRecord::Schema.define(:version => 20131013222538) do

  create_table "artworks", :force => true do |t|
    t.string   "title"
    t.string   "medium"
    t.string   "dimensions"
    t.date     "release_date"
    t.integer  "artist_id"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "people", :force => true do |t|
    t.string   "name"
    t.text     "bio"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "people_roles", :force => true do |t|
    t.integer "person_id", :null => false
    t.integer "role_id",   :null => false
  end

  add_index "people_roles", ["person_id", "role_id"], :name => "by_person_and_role", :unique => true

  create_table "representations", :force => true do |t|
    t.date     "start_date"
    t.date     "end_date"
    t.boolean  "current"
    t.integer  "person_id"
    t.integer  "represented_id"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  create_table "roles", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

end
