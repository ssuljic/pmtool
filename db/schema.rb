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

ActiveRecord::Schema.define(version: 20141221171935) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "activities", force: true do |t|
    t.integer  "project_id",  null: false
    t.string   "name"
    t.text     "description"
    t.integer  "duration"
    t.boolean  "finished"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "activities", ["project_id"], name: "index_activities_on_project_id", using: :btree

  create_table "binaries", force: true do |t|
    t.binary "data"
  end

  create_table "comments", force: true do |t|
    t.integer  "user_id",    null: false
    t.integer  "task_id",    null: false
    t.string   "content"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "meeting", force: true do |t|
    t.integer  "project_id",          null: false
    t.integer  "user_id",             null: false
    t.string   "description"
    t.string   "location"
    t.boolean  "scheduling_finished"
    t.integer  "attending_members"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "meetings", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "period", force: true do |t|
    t.integer  "meeting_id", null: false
    t.date     "from"
    t.date     "to"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "projects", force: true do |t|
    t.string   "name"
    t.text     "short_description"
    t.text     "long_description"
    t.date     "start_date"
    t.date     "end_date"
    t.integer  "duration"
    t.integer  "member_count"
    t.float    "budget"
    t.boolean  "finished"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "roles", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tasks", force: true do |t|
    t.integer  "activity_id",   null: false
    t.integer  "user_id",       null: false
    t.string   "name"
    t.text     "description"
    t.integer  "duration"
    t.date     "deadline"
    t.float    "status"
    t.integer  "real_duration"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "tasks", ["activity_id"], name: "index_tasks_on_activity_id", using: :btree
  add_index "tasks", ["user_id"], name: "index_tasks_on_user_id", using: :btree

  create_table "uploads", force: true do |t|
    t.string   "filename"
    t.string   "content_type"
    t.integer  "size"
    t.integer  "task_id"
    t.integer  "binary_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_activities", force: true do |t|
    t.integer  "user_id",     null: false
    t.integer  "activity_id", null: false
    t.integer  "role_id",     null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "user_activities", ["activity_id"], name: "index_user_activities_on_activity_id", using: :btree
  add_index "user_activities", ["role_id"], name: "index_user_activities_on_role_id", using: :btree
  add_index "user_activities", ["user_id"], name: "index_user_activities_on_user_id", using: :btree

  create_table "user_projects", force: true do |t|
    t.integer  "user_id",         null: false
    t.integer  "project_id",      null: false
    t.integer  "role_id",         null: false
    t.integer  "number_of_hours"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "user_projects", ["project_id"], name: "index_user_projects_on_project_id", using: :btree
  add_index "user_projects", ["role_id"], name: "index_user_projects_on_role_id", using: :btree
  add_index "user_projects", ["user_id"], name: "index_user_projects_on_user_id", using: :btree

  create_table "users", force: true do |t|
    t.string   "name"
    t.string   "surname"
    t.string   "email"
    t.string   "username"
    t.string   "password_digest"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "session_key"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["username"], name: "index_users_on_username", unique: true, using: :btree

end
