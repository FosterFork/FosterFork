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

ActiveRecord::Schema.define(version: 20160424175013) do

  create_table "abuse_reports", force: :cascade do |t|
    t.integer  "project_id"
    t.integer  "reporter_id"
    t.integer  "resolver_id"
    t.text     "reason"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "active_admin_comments", force: :cascade do |t|
    t.string   "namespace"
    t.text     "body"
    t.string   "resource_id",   null: false
    t.string   "resource_type", null: false
    t.integer  "author_id"
    t.string   "author_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id"
  add_index "active_admin_comments", ["namespace"], name: "index_active_admin_comments_on_namespace"
  add_index "active_admin_comments", ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id"

  create_table "categories", force: :cascade do |t|
    t.string   "name"
    t.string   "color"
    t.integer  "priority",   default: 0, null: false
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "comments", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "message_id"
    t.text     "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "comments", ["message_id"], name: "index_comments_on_message_id"
  add_index "comments", ["user_id"], name: "index_comments_on_user_id"

  create_table "images", force: :cascade do |t|
    t.integer  "project_id"
    t.string   "alt"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
  end

  add_index "images", ["project_id"], name: "index_images_on_project_id"

  create_table "inquiries", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "project_id"
    t.text     "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "inquiries", ["project_id"], name: "index_inquiries_on_project_id"
  add_index "inquiries", ["user_id"], name: "index_inquiries_on_user_id"

  create_table "messages", force: :cascade do |t|
    t.integer  "project_id"
    t.integer  "user_id"
    t.string   "title"
    t.text     "content"
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.boolean  "comments_allowed", default: true, null: false
  end

  add_index "messages", ["project_id"], name: "index_messages_on_project_id"
  add_index "messages", ["user_id"], name: "index_messages_on_user_id"

  create_table "participations", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "project_id"
    t.string   "secret"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "participations", ["project_id"], name: "index_participations_on_project_id"
  add_index "participations", ["secret"], name: "index_participations_on_secret"
  add_index "participations", ["user_id", "project_id"], name: "index_participations_on_user_id_and_project_id", unique: true
  add_index "participations", ["user_id"], name: "index_participations_on_user_id"

  create_table "projects", force: :cascade do |t|
    t.integer  "owner_id"
    t.string   "slug"
    t.string   "recurrence"
    t.string   "title"
    t.text     "abstract"
    t.text     "description"
    t.string   "address"
    t.string   "city"
    t.string   "zip"
    t.string   "country"
    t.datetime "date"
    t.decimal  "latitude",             precision: 15, scale: 10
    t.decimal  "longitude",            precision: 15, scale: 10
    t.boolean  "approved",                                       default: false, null: false
    t.boolean  "public",                                         default: false, null: false
    t.boolean  "active",                                         default: false, null: false
    t.boolean  "participation_wanted",                           default: false, null: false
    t.string   "secret"
    t.datetime "created_at",                                                     null: false
    t.datetime "updated_at",                                                     null: false
    t.integer  "category_id"
    t.boolean  "inquiries_allowed",                              default: false, null: false
  end

  add_index "projects", ["category_id"], name: "index_projects_on_category_id"
  add_index "projects", ["slug"], name: "index_projects_on_slug", unique: true

  create_table "text_blocks", force: :cascade do |t|
    t.string   "name"
    t.string   "title"
    t.text     "body"
    t.string   "locale"
    t.boolean  "public"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "translations", force: :cascade do |t|
    t.string   "title"
    t.string   "locale"
    t.integer  "translatable_id"
    t.string   "translatable_type"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

  add_index "translations", ["translatable_id"], name: "index_translations_on_translatable_id"

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "phone"
    t.string   "zip"
    t.string   "country"
    t.boolean  "newsletter",                                       default: false, null: false
    t.boolean  "is_admin",                                         default: false, null: false
    t.string   "locale"
    t.string   "email_format"
    t.string   "email",                                            default: "",    null: false
    t.string   "encrypted_password",                               default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "uid"
    t.string   "provider"
    t.datetime "created_at",                                                       null: false
    t.datetime "updated_at",                                                       null: false
    t.decimal  "latitude",               precision: 15, scale: 10
    t.decimal  "longitude",              precision: 15, scale: 10
    t.boolean  "mail_on_nearby_project",                           default: false, null: false
    t.decimal  "project_proximity"
  end

  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

end
