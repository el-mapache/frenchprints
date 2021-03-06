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

ActiveRecord::Schema.define(:version => 20131124230839) do

  create_table "articles", :force => true do |t|
    t.string   "title",          :null => false
    t.date     "date_published", :null => false
    t.string   "pages",          :null => false
    t.integer  "journal_id",     :null => false
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
    t.string   "issue_number"
  end

  create_table "artworks", :force => true do |t|
    t.string   "title"
    t.string   "medium"
    t.string   "dimensions"
    t.date     "release_date"
    t.integer  "artist_id"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "authors_articles", :force => true do |t|
    t.integer  "article_id", :null => false
    t.integer  "person_id",  :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "exhibitions", :force => true do |t|
    t.string   "name"
    t.integer  "gallery_id"
    t.integer  "person_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.text     "description"
  end

  create_table "exhibitions_artists", :force => true do |t|
    t.integer  "exhibition_id"
    t.integer  "person_id"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  create_table "galleries", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "journals", :force => true do |t|
    t.string   "title"
    t.string   "publication_run"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  create_table "locations", :force => true do |t|
    t.date     "start_date"
    t.date     "end_date"
    t.string   "city"
    t.string   "country"
    t.string   "country_code"
    t.string   "street_address"
    t.string   "latitude"
    t.string   "longitude"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
    t.string   "state"
    t.string   "province"
    t.integer  "locatable_id",   :null => false
    t.string   "locatable_type", :null => false
    t.string   "event_name"
  end

  create_table "media", :force => true do |t|
    t.string   "image"
    t.integer  "imagable_id"
    t.string   "imagable_type"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  create_table "ownerships", :force => true do |t|
    t.integer  "artwork_id"
    t.integer  "person_id"
    t.date     "start_date"
    t.date     "end_date"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "people", :force => true do |t|
    t.string   "name"
    t.text     "bio"
    t.datetime "created_at",                  :null => false
    t.datetime "updated_at",                  :null => false
    t.string   "blurb"
    t.string   "sex",        :default => "U", :null => false
  end

  create_table "people_roles", :force => true do |t|
    t.integer "person_id", :null => false
    t.integer "role_id",   :null => false
  end

  add_index "people_roles", ["person_id", "role_id"], :name => "by_person_and_role", :unique => true

  create_table "personnel_histories", :force => true do |t|
    t.integer  "person_id"
    t.date     "start_date"
    t.date     "end_date"
    t.integer  "trackable_id"
    t.string   "trackable_type"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
    t.integer  "location_id",    :null => false
    t.string   "title"
  end

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

  create_table "subjects", :force => true do |t|
    t.integer  "article_id",       :null => false
    t.integer  "subjectable_id"
    t.string   "subjectable_type"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

  create_table "transactions", :force => true do |t|
    t.text     "description"
    t.integer  "artwork_id"
    t.integer  "buyer_id"
    t.integer  "seller_id"
    t.date     "sold_on"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "email",                  :default => "",    :null => false
    t.string   "encrypted_password",     :default => "",    :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0,     :null => false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                                :null => false
    t.datetime "updated_at",                                :null => false
    t.boolean  "admin",                  :default => false
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
