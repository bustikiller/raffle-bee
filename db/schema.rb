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

ActiveRecord::Schema.define(version: 2019_05_10_175206) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "assignments", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "raffle_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["raffle_id", "user_id"], name: "index_assignments_on_raffle_id_and_user_id", unique: true
    t.index ["raffle_id"], name: "index_assignments_on_raffle_id"
    t.index ["user_id"], name: "index_assignments_on_user_id"
  end

  create_table "raffles", force: :cascade do |t|
    t.string "name", null: false
    t.date "starts_on", null: false
    t.date "ends_on", null: false
    t.integer "max_number_of_tickets", null: false
    t.decimal "price", precision: 5, scale: 2, null: false
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "award"
    t.index ["user_id"], name: "index_raffles_on_user_id"
  end

  create_table "results", force: :cascade do |t|
    t.date "date", null: false
    t.integer "number", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "riews_action_links", force: :cascade do |t|
    t.string "base_path"
    t.string "display_pattern"
    t.boolean "absolute", default: false, null: false
    t.bigint "riews_column_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "http_verb", limit: 2, default: 0, null: false
    t.index ["riews_column_id"], name: "index_riews_action_links_on_riews_column_id"
  end

  create_table "riews_arguments", force: :cascade do |t|
    t.string "value", null: false
    t.bigint "argumentable_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "position", default: 0, null: false
    t.string "argumentable_type"
    t.index ["argumentable_id"], name: "index_riews_arguments_on_argumentable_id"
  end

  create_table "riews_columns", force: :cascade do |t|
    t.string "method"
    t.bigint "riews_view_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "prefix"
    t.string "postfix"
    t.integer "aggregate", limit: 2
    t.string "name"
    t.string "pattern"
    t.boolean "hide_from_display", default: false
    t.integer "position", default: 0, null: false
    t.index ["riews_view_id"], name: "index_riews_columns_on_riews_view_id"
  end

  create_table "riews_filter_criterias", force: :cascade do |t|
    t.string "field_name"
    t.integer "operator", limit: 2, null: false
    t.bigint "riews_view_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "negation", default: false, null: false
    t.integer "position", default: 0, null: false
    t.index ["riews_view_id"], name: "index_riews_filter_criterias_on_riews_view_id"
  end

  create_table "riews_relationships", force: :cascade do |t|
    t.string "name"
    t.bigint "riews_view_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "position", default: 0, null: false
    t.index ["riews_view_id"], name: "index_riews_relationships_on_riews_view_id"
  end

  create_table "riews_views", force: :cascade do |t|
    t.string "name", null: false
    t.string "model"
    t.string "code", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "paginator_size", default: 0, null: false
    t.boolean "uniqueness", default: false, null: false
  end

  create_table "tickets", force: :cascade do |t|
    t.bigint "raffle_id"
    t.bigint "user_id"
    t.integer "number", null: false
    t.string "email", null: false
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["raffle_id"], name: "index_tickets_on_raffle_id"
    t.index ["user_id"], name: "index_tickets_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "role_id"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "assignments", "raffles"
  add_foreign_key "assignments", "users"
  add_foreign_key "raffles", "users"
  add_foreign_key "riews_action_links", "riews_columns"
  add_foreign_key "riews_columns", "riews_views"
  add_foreign_key "riews_filter_criterias", "riews_views"
  add_foreign_key "riews_relationships", "riews_views"
  add_foreign_key "tickets", "raffles"
  add_foreign_key "tickets", "users"
end
