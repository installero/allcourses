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

ActiveRecord::Schema.define(version: 20180114190432) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "courses", force: :cascade do |t|
    t.bigint "provider_id"
    t.string "url", null: false
    t.string "title", null: false
    t.text "description"
    t.integer "genre", default: 0, null: false
    t.float "rating", default: 0.0, null: false
    t.integer "reviews_count", default: 0, null: false
    t.integer "ratings_count", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.string "picture"
    t.index ["genre"], name: "index_courses_on_genre"
    t.index ["provider_id"], name: "index_courses_on_provider_id"
    t.index ["url"], name: "index_courses_on_url", unique: true
    t.index ["user_id"], name: "index_courses_on_user_id"
  end

  create_table "oauth_identities", force: :cascade do |t|
    t.bigint "user_id"
    t.string "provider"
    t.string "uid"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_oauth_identities_on_user_id"
  end

  create_table "providers", force: :cascade do |t|
    t.string "title", null: false
    t.string "domain", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["domain"], name: "index_providers_on_domain", unique: true
  end

  create_table "reviews", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "course_id"
    t.integer "rating"
    t.text "text"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "html"
    t.index ["course_id"], name: "index_reviews_on_course_id"
    t.index ["user_id"], name: "index_reviews_on_user_id"
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
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "admin"
    t.string "first_name"
    t.string "last_name"
    t.string "avatar"
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "courses", "providers", on_update: :cascade, on_delete: :restrict
  add_foreign_key "courses", "users", on_update: :cascade, on_delete: :restrict
  add_foreign_key "oauth_identities", "users"
  add_foreign_key "reviews", "courses", on_update: :cascade, on_delete: :cascade
  add_foreign_key "reviews", "users", on_update: :cascade, on_delete: :restrict
end
