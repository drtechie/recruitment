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

ActiveRecord::Schema.define(version: 2018_10_03_172759) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_admin_comments", force: :cascade do |t|
    t.string "namespace"
    t.text "body"
    t.string "resource_type"
    t.bigint "resource_id"
    t.string "author_type"
    t.bigint "author_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id"
    t.index ["namespace"], name: "index_active_admin_comments_on_namespace"
    t.index ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id"
  end

  create_table "attempt_transitions", force: :cascade do |t|
    t.string "to_state", null: false
    t.json "metadata", default: {}
    t.integer "sort_key", null: false
    t.integer "attempt_id", null: false
    t.boolean "most_recent", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["attempt_id", "most_recent"], name: "index_attempt_transitions_parent_most_recent", unique: true, where: "most_recent"
    t.index ["attempt_id", "sort_key"], name: "index_attempt_transitions_parent_sort", unique: true
  end

  create_table "attempts", force: :cascade do |t|
    t.datetime "started_at"
    t.datetime "ended_at"
    t.bigint "interviewee_id"
    t.bigint "interview_id"
    t.jsonb "response"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["interview_id"], name: "index_attempts_on_interview_id"
    t.index ["interviewee_id"], name: "index_attempts_on_interviewee_id"
  end

  create_table "attempts_categories", force: :cascade do |t|
    t.bigint "attempt_id"
    t.bigint "category_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["attempt_id"], name: "index_attempts_categories_on_attempt_id"
    t.index ["category_id"], name: "index_attempts_categories_on_category_id"
  end

  create_table "attempts_questions", force: :cascade do |t|
    t.bigint "attempt_id"
    t.bigint "question_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["attempt_id"], name: "index_attempts_questions_on_attempt_id"
    t.index ["question_id"], name: "index_attempts_questions_on_question_id"
  end

  create_table "categories", force: :cascade do |t|
    t.string "name"
    t.bigint "parent_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_categories_on_name"
  end

  create_table "categories_questions", force: :cascade do |t|
    t.bigint "category_id"
    t.bigint "question_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["category_id"], name: "index_categories_questions_on_category_id"
    t.index ["question_id"], name: "index_categories_questions_on_question_id"
  end

  create_table "essays", force: :cascade do |t|
    t.integer "answer_min_length"
    t.integer "answer_max_length"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "interviewees", force: :cascade do |t|
    t.string "auth_code"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_interviewees_on_user_id"
  end

  create_table "interviews", force: :cascade do |t|
    t.string "name"
    t.jsonb "config"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "interviews_categories", force: :cascade do |t|
    t.bigint "interview_id"
    t.bigint "category_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["category_id"], name: "index_interviews_categories_on_category_id"
    t.index ["interview_id"], name: "index_interviews_categories_on_interview_id"
  end

  create_table "mcqs", force: :cascade do |t|
    t.text "options", default: [], array: true
    t.integer "correct_options", default: [], array: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "questions", force: :cascade do |t|
    t.string "title"
    t.string "questionable_type"
    t.bigint "questionable_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["questionable_type", "questionable_id"], name: "index_questions_on_questionable_type_and_questionable_id"
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
    t.integer "failed_attempts", default: 0, null: false
    t.string "unlock_token"
    t.datetime "locked_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "title"
    t.string "first_name"
    t.string "middle_name"
    t.string "last_name"
    t.boolean "admin"
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["unlock_token"], name: "index_users_on_unlock_token", unique: true
  end

  add_foreign_key "attempt_transitions", "attempts"
  add_foreign_key "attempts", "interviewees"
  add_foreign_key "attempts", "interviews"
  add_foreign_key "attempts_categories", "attempts"
  add_foreign_key "attempts_categories", "categories"
  add_foreign_key "attempts_questions", "attempts"
  add_foreign_key "attempts_questions", "questions"
  add_foreign_key "categories_questions", "categories"
  add_foreign_key "categories_questions", "questions"
  add_foreign_key "interviewees", "users"
  add_foreign_key "interviews_categories", "categories"
  add_foreign_key "interviews_categories", "interviews"
end
