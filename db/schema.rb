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

ActiveRecord::Schema.define(:version => 20130428141643) do

  create_table "contacts", :force => true do |t|
    t.integer  "user_id"
    t.string   "first_name"
    t.string   "last_name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "emails", :force => true do |t|
    t.integer  "contact_id"
    t.string   "address"
    t.string   "description"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "profiles", :force => true do |t|
    t.string   "description"
    t.integer  "user_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "profiles_emails", :id => false, :force => true do |t|
    t.integer "profile_id"
    t.integer "email_id"
  end

  create_table "users", :force => true do |t|
    t.string   "username"
    t.integer  "contact_id"
    t.string   "email"
    t.string   "password_salt"
    t.string   "password_hash"
    t.string   "state"
    t.string   "email_state"
    t.string   "email_confirmation_salt"
    t.datetime "created_at",              :null => false
    t.datetime "updated_at",              :null => false
  end

end
