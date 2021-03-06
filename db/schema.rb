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

ActiveRecord::Schema.define(version: 20151215020854) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "candidates", force: :cascade do |t|
    t.integer  "research_id"
    t.integer  "user_id"
    t.integer  "status"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "candidates", ["research_id"], name: "index_candidates_on_research_id", using: :btree
  add_index "candidates", ["user_id"], name: "index_candidates_on_user_id", using: :btree

  create_table "meetings", force: :cascade do |t|
    t.datetime "start_at"
    t.datetime "end_at"
    t.integer  "research_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "meetings", ["research_id"], name: "index_meetings_on_research_id", using: :btree

  create_table "notes", force: :cascade do |t|
    t.text     "body"
    t.integer  "meeting_id", null: false
    t.integer  "user_id",    null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "notes", ["meeting_id"], name: "index_notes_on_meeting_id", using: :btree
  add_index "notes", ["user_id"], name: "index_notes_on_user_id", using: :btree

  create_table "participants", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "meeting_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "participants", ["meeting_id"], name: "index_participants_on_meeting_id", using: :btree
  add_index "participants", ["user_id"], name: "index_participants_on_user_id", using: :btree

  create_table "profiles", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "sex"
    t.date     "birthday"
    t.integer  "age"
    t.integer  "prefecture"
    t.integer  "job"
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
    t.string   "username",   limit: 32, default: "", null: false
  end

  add_index "profiles", ["user_id"], name: "index_profiles_on_user_id", using: :btree

  create_table "questions", force: :cascade do |t|
    t.integer  "research_id"
    t.text     "text"
    t.integer  "pass_answer"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "questions", ["research_id"], name: "index_questions_on_research_id", using: :btree

  create_table "researches", force: :cascade do |t|
    t.string   "title"
    t.datetime "start_at"
    t.datetime "end_at"
    t.integer  "reward"
    t.integer  "max_users"
    t.integer  "min_users"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "rooms", force: :cascade do |t|
    t.string   "token"
    t.integer  "meeting_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "rooms", ["meeting_id"], name: "index_rooms_on_meeting_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "",     null: false
    t.string   "encrypted_password",     default: "",     null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,      null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                              null: false
    t.datetime "updated_at",                              null: false
    t.string   "role",                   default: "user", null: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  add_foreign_key "candidates", "researches"
  add_foreign_key "candidates", "users"
  add_foreign_key "meetings", "researches"
  add_foreign_key "notes", "meetings"
  add_foreign_key "notes", "users"
  add_foreign_key "participants", "meetings"
  add_foreign_key "participants", "users"
  add_foreign_key "profiles", "users"
  add_foreign_key "questions", "researches"
  add_foreign_key "rooms", "meetings"
end
