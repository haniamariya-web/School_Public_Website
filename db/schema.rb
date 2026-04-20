# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[8.1].define(version: 2026_04_16_112923) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "active_admin_comments", force: :cascade do |t|
    t.bigint "author_id"
    t.string "author_type"
    t.text "body"
    t.datetime "created_at", null: false
    t.string "namespace"
    t.bigint "resource_id"
    t.string "resource_type"
    t.datetime "updated_at", null: false
    t.index ["author_type", "author_id"], name: "index_active_admin_comments_on_author"
    t.index ["namespace"], name: "index_active_admin_comments_on_namespace"
    t.index ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource"
  end

  create_table "admin_users", force: :cascade do |t|
    t.string "admin_code", null: false
    t.datetime "created_at", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.datetime "remember_created_at"
    t.datetime "reset_password_sent_at"
    t.string "reset_password_token"
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_admin_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true
  end

  create_table "album_posts", force: :cascade do |t|
    t.bigint "album_id", null: false
    t.datetime "created_at", null: false
    t.integer "display_order"
    t.bigint "post_id", null: false
    t.datetime "updated_at", null: false
    t.index ["album_id"], name: "index_album_posts_on_album_id"
    t.index ["post_id"], name: "index_album_posts_on_post_id"
  end

  create_table "albums", force: :cascade do |t|
    t.bigint "campus_id", null: false
    t.datetime "created_at", null: false
    t.text "description"
    t.date "event_date"
    t.string "title"
    t.datetime "updated_at", null: false
    t.index ["campus_id"], name: "index_albums_on_campus_id"
  end

  create_table "campus", force: :cascade do |t|
    t.string "address"
    t.datetime "created_at", null: false
    t.string "email"
    t.string "name"
    t.string "phone"
    t.string "principal_name"
    t.datetime "updated_at", null: false
  end

  create_table "inquiries", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "email"
    t.string "grade_level"
    t.text "message"
    t.string "name"
    t.string "phone"
    t.integer "preferred_call_time"
    t.integer "status"
    t.datetime "updated_at", null: false
  end

  create_table "posts", force: :cascade do |t|
    t.bigint "campus_id", null: false
    t.text "content"
    t.datetime "created_at", null: false
    t.integer "post_type"
    t.datetime "published_at"
    t.string "title"
    t.datetime "updated_at", null: false
    t.index ["campus_id"], name: "index_posts_on_campus_id"
  end

  create_table "results", force: :cascade do |t|
    t.string "academic_year"
    t.bigint "campus_id", null: false
    t.datetime "created_at", null: false
    t.string "grade"
    t.string "level"
    t.integer "obtained_marks"
    t.string "roll_number"
    t.string "student_name"
    t.integer "total_marks"
    t.datetime "updated_at", null: false
    t.index ["campus_id"], name: "index_results_on_campus_id"
  end

  add_foreign_key "album_posts", "albums"
  add_foreign_key "album_posts", "posts"
  add_foreign_key "albums", "campus", column: "campus_id"
  add_foreign_key "posts", "campus", column: "campus_id"
  add_foreign_key "results", "campus", column: "campus_id"
end
