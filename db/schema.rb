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

ActiveRecord::Schema.define(version: 20170629011617) do

  create_table "categories", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "group_users", force: :cascade do |t|
    t.integer  "group_id"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["group_id"], name: "index_group_users_on_group_id"
    t.index ["user_id", "group_id"], name: "index_group_users_on_user_id_and_group_id", unique: true
    t.index ["user_id"], name: "index_group_users_on_user_id"
  end

  create_table "groups", force: :cascade do |t|
    t.string   "title"
    t.datetime "time"
    t.text     "address"
    t.text     "other"
    t.boolean  "completed",   default: false
    t.integer  "size"
    t.integer  "creator_id"
    t.integer  "category_id"
    t.float    "longitude"
    t.float    "latitude"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.integer  "status",      default: 0
    t.integer  "place_id"
    t.index ["creator_id"], name: "index_groups_on_creator_id"
  end

  create_table "leave_groups", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "group_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["group_id"], name: "index_leave_groups_on_group_id"
    t.index ["user_id"], name: "index_leave_groups_on_user_id"
  end

  create_table "markers", force: :cascade do |t|
    t.float    "longitude"
    t.float    "latitude"
    t.integer  "address"
    t.integer  "group_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["group_id"], name: "index_markers_on_group_id"
  end

  create_table "menu_items", force: :cascade do |t|
    t.integer  "menu_id"
    t.string   "name"
    t.integer  "price"
    t.text     "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "menus", force: :cascade do |t|
    t.string   "name"
    t.integer  "place_id"
    t.text     "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "messages", force: :cascade do |t|
    t.text     "content"
    t.integer  "user_id"
    t.integer  "group_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["group_id"], name: "index_messages_on_group_id"
    t.index ["user_id"], name: "index_messages_on_user_id"
  end

  create_table "notifications", force: :cascade do |t|
    t.integer  "user_id"
    t.text     "content"
    t.string   "notifiable_type"
    t.integer  "notifiable_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.index ["user_id"], name: "index_notifications_on_user_id"
  end

  create_table "pictures", force: :cascade do |t|
    t.string   "image"
    t.string   "imageable_type"
    t.integer  "imageable_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  create_table "places", force: :cascade do |t|
    t.string   "title"
    t.text     "address"
    t.float    "longitude"
    t.float    "latitude"
    t.string   "website"
    t.text     "description"
    t.integer  "category_id"
    t.integer  "manager_id"
    t.boolean  "is_approved", default: false
    t.string   "phonenumber"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  create_table "profiles", force: :cascade do |t|
    t.string   "name"
    t.date     "birthday"
    t.integer  "gender",      default: 0, null: false
    t.text     "address"
    t.string   "job"
    t.string   "phonenumber"
    t.string   "avatar"
    t.text     "description"
    t.integer  "user_id"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.index ["user_id"], name: "index_profiles_on_user_id"
  end

  create_table "reports", force: :cascade do |t|
    t.integer  "reporter_id"
    t.string   "reported_type"
    t.integer  "reported_id"
    t.text     "content"
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.boolean  "resolved",      default: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "email"
    t.boolean  "is_admin",            default: false
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "encrypted_password",  default: "",    null: false
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",       default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.boolean  "activated",           default: true
    t.boolean  "is_manager"
    t.index ["email"], name: "index_users_on_email", unique: true
  end

end
