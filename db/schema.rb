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

ActiveRecord::Schema.define(version: 2020_08_01_091139) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "pgcrypto"
  enable_extension "plpgsql"

  create_table "article_series", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name", null: false
    t.string "summary", null: false
    t.integer "publish_status", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "articles", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "article_series_id", null: false
    t.string "title", null: false
    t.text "sentence"
    t.integer "publish_status", null: false
    t.datetime "published_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["article_series_id"], name: "index_articles_on_article_series_id"
    t.index ["publish_status"], name: "index_articles_on_publish_status"
  end

  create_table "groups", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name", null: false
    t.date "active_date"
    t.date "deactive_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "information", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "information_category_id", null: false
    t.string "title", null: false
    t.string "scentence"
    t.integer "publish_status", null: false
    t.datetime "published_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["information_category_id"], name: "index_information_on_information_category_id"
    t.index ["publish_status"], name: "index_information_on_publish_status"
  end

  create_table "information_categories", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "group_id"
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["group_id"], name: "index_information_categories_on_group_id"
  end

  create_table "link_categories", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name"
    t.integer "disp_order"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "links", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "link_category_id", null: false
    t.string "name"
    t.string "note"
    t.text "url"
    t.integer "disp_order"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["link_category_id"], name: "index_links_on_link_category_id"
  end

  create_table "project_statuses", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "project_id", null: false
    t.integer "user_id", null: false
    t.string "status", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["project_id"], name: "index_project_statuses_on_project_id"
    t.index ["user_id"], name: "index_project_statuses_on_user_id"
  end

  create_table "projects", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "group_id"
    t.uuid "parent_id"
    t.string "name", null: false
    t.string "summary"
    t.date "start_date"
    t.date "end_date"
    t.boolean "closed", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["group_id"], name: "index_projects_on_group_id"
    t.index ["parent_id"], name: "index_projects_on_parent_id"
  end

  create_table "user_groups", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.bigint "user_id", null: false
    t.uuid "group_id", null: false
    t.integer "belonging_type", null: false
    t.date "start_date"
    t.date "end_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["belonging_type"], name: "index_user_groups_on_belonging_type"
    t.index ["group_id"], name: "index_user_groups_on_group_id"
    t.index ["user_id"], name: "index_user_groups_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "first_name"
    t.string "last_name"
    t.string "first_name_initial"
    t.string "last_name_initial"
    t.string "first_name_en"
    t.string "last_name_en"
    t.boolean "suspended", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "articles", "article_series"
  add_foreign_key "information", "information_categories"
  add_foreign_key "information_categories", "groups"
  add_foreign_key "links", "link_categories"
  add_foreign_key "project_statuses", "projects"
  add_foreign_key "project_statuses", "users"
  add_foreign_key "projects", "groups"
  add_foreign_key "projects", "projects", column: "parent_id"
  add_foreign_key "user_groups", "groups"
  add_foreign_key "user_groups", "users"
end
