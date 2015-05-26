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

ActiveRecord::Schema.define(version: 20150525054835) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "hstore"

  create_table "comments", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "commentable_type"
    t.integer  "commentable_id"
    t.text     "content"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.index ["commentable_type", "commentable_id"], name: "index_comments_on_commentable_type_and_commentable_id", using: :btree
    t.index ["user_id"], name: "index_comments_on_user_id", using: :btree
  end

  create_table "courses", force: :cascade do |t|
    t.string   "name"
    t.string   "identifier"
    t.integer  "subject_id"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.integer  "ups",            default: 0, null: false
    t.integer  "downs",          default: 0, null: false
    t.integer  "comments_count", default: 0, null: false
    t.index ["identifier"], name: "index_courses_on_identifier", using: :btree
    t.index ["subject_id"], name: "index_courses_on_subject_id", using: :btree
    t.index ["updated_at"], name: "index_hot_on_courses", using: :btree
  end

  create_table "delayed_jobs", force: :cascade do |t|
    t.integer  "priority",   default: 0, null: false
    t.integer  "attempts",   default: 0, null: false
    t.text     "handler",                null: false
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.string   "queue"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["priority", "run_at"], name: "delayed_jobs_priority", using: :btree
  end

  create_table "instructors", force: :cascade do |t|
    t.string   "name"
    t.string   "identifier"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.integer  "ups",            default: 0, null: false
    t.integer  "downs",          default: 0, null: false
    t.integer  "comments_count", default: 0, null: false
    t.index ["identifier"], name: "index_instructors_on_identifier", using: :btree
    t.index ["updated_at"], name: "index_hot_on_instructors", using: :btree
  end

  create_table "instructors_sections", id: false, force: :cascade do |t|
    t.integer "instructor_id", null: false
    t.integer "section_id",    null: false
    t.index ["instructor_id", "section_id"], name: "index_instructors_sections_on_instructor_id_and_section_id", using: :btree
    t.index ["section_id", "instructor_id"], name: "index_instructors_sections_on_section_id_and_instructor_id", using: :btree
  end

  create_table "sections", force: :cascade do |t|
    t.string   "name"
    t.string   "call_number"
    t.string   "status"
    t.integer  "open_seats"
    t.integer  "total_seats"
    t.integer  "course_id"
    t.integer  "term_id"
    t.string   "identifier"
    t.string   "days"
    t.time     "starts_at"
    t.time     "ends_at"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["call_number"], name: "index_sections_on_call_number", using: :btree
    t.index ["course_id"], name: "index_sections_on_course_id", using: :btree
    t.index ["identifier"], name: "index_sections_on_identifier", using: :btree
    t.index ["status"], name: "index_sections_on_status", using: :btree
    t.index ["term_id"], name: "index_sections_on_term_id", using: :btree
  end

  create_table "subjects", force: :cascade do |t|
    t.string   "name"
    t.string   "identifier"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["identifier"], name: "index_subjects_on_identifier", using: :btree
  end

  create_table "subscriptions", force: :cascade do |t|
    t.integer  "section_id"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["section_id"], name: "index_subscriptions_on_section_id", using: :btree
    t.index ["user_id"], name: "index_subscriptions_on_user_id", using: :btree
  end

  create_table "terms", force: :cascade do |t|
    t.string   "name"
    t.string   "identifier"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["identifier"], name: "index_terms_on_identifier", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.string   "phone"
    t.string   "password_digest"
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.string   "remember_digest"
    t.string   "activation_digest"
    t.boolean  "activated",              default: false
    t.datetime "activated_at"
    t.string   "password_reset_digest"
    t.datetime "password_reset_sent_at"
    t.index ["email"], name: "index_users_on_email", using: :btree
  end

  create_table "votes", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "voteable_id"
    t.string   "voteable_type"
    t.integer  "points"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.index ["points"], name: "index_votes_on_points", using: :btree
    t.index ["user_id"], name: "index_votes_on_user_id", using: :btree
    t.index ["voteable_id", "voteable_type"], name: "index_votes_on_voteable_id_and_voteable_type", using: :btree
  end

end
