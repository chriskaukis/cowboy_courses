# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20091006025800) do

  create_table "comments", :force => true do |t|
    t.integer  "user_id"
    t.string   "commentable_type"
    t.integer  "commentable_id"
    t.text     "content"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "comments", ["commentable_id", "commentable_type"], :name => "index_comments_on_commentable_id_and_commentable_type"
  add_index "comments", ["user_id"], :name => "index_comments_on_user_id"

  create_table "courses", :force => true do |t|
    t.string   "name",                          :null => false
    t.string   "identifier",                    :null => false
    t.integer  "subject_id",                    :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "ups",            :default => 0, :null => false
    t.integer  "downs",          :default => 0, :null => false
    t.integer  "comments_count", :default => 0, :null => false
  end

  add_index "courses", ["identifier"], :name => "index_courses_on_identifier"
  add_index "courses", ["name"], :name => "index_courses_on_name"
  add_index "courses", ["subject_id"], :name => "index_courses_on_subject_id"
  add_index "courses", [nil, "updated_at"], :name => "index_hot_on_courses"

  create_table "delayed_jobs", :force => true do |t|
    t.integer  "priority",   :default => 0
    t.integer  "attempts",   :default => 0
    t.text     "handler"
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "instructors", :force => true do |t|
    t.string   "name",                          :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "ups",            :default => 0, :null => false
    t.integer  "downs",          :default => 0, :null => false
    t.integer  "comments_count", :default => 0, :null => false
  end

  add_index "instructors", ["name"], :name => "index_instructors_on_name"
  add_index "instructors", [nil, "updated_at"], :name => "index_hot_on_instructors"

  create_table "open_id_authentication_associations", :force => true do |t|
    t.integer "issued"
    t.integer "lifetime"
    t.string  "handle"
    t.string  "assoc_type"
    t.binary  "server_url"
    t.binary  "secret"
  end

  create_table "open_id_authentication_nonces", :force => true do |t|
    t.integer "timestamp",  :null => false
    t.string  "server_url"
    t.string  "salt",       :null => false
  end

  create_table "sections", :force => true do |t|
    t.string   "name"
    t.string   "call_number",                                        :null => false
    t.string   "status",                      :default => "unknown", :null => false
    t.integer  "open_seats"
    t.integer  "total_seats"
    t.integer  "instructor_id"
    t.integer  "term_id",                                            :null => false
    t.integer  "course_id",                                          :null => false
    t.string   "identifier",                                         :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.time     "starts_at"
    t.time     "ends_at"
    t.string   "days",          :limit => 10
    t.text     "notes"
  end

  add_index "sections", ["call_number"], :name => "index_sections_on_call_number"
  add_index "sections", ["course_id"], :name => "index_sections_on_course_id"
  add_index "sections", ["identifier"], :name => "index_sections_on_identifier"
  add_index "sections", ["instructor_id"], :name => "index_sections_on_instructor_id"
  add_index "sections", ["name"], :name => "index_sections_on_name"
  add_index "sections", ["term_id"], :name => "index_sections_on_term_id"

  create_table "subjects", :force => true do |t|
    t.string   "name",       :null => false
    t.string   "identifier", :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "subjects", ["identifier"], :name => "index_subjects_on_identifier"
  add_index "subjects", ["name"], :name => "index_subjects_on_name"

  create_table "subscriptions", :force => true do |t|
    t.integer  "user_id"
    t.integer  "section_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "status_notification",     :default => false
    t.boolean  "instructor_notification", :default => false
  end

  add_index "subscriptions", ["user_id", "section_id"], :name => "index_subscriptions_on_user_id_and_section_id", :unique => true

  create_table "terms", :force => true do |t|
    t.string   "name",                          :null => false
    t.string   "identifier",                    :null => false
    t.boolean  "disabled",   :default => false, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "terms", ["identifier"], :name => "index_terms_on_identifier"
  add_index "terms", ["name"], :name => "index_terms_on_name"

  create_table "users", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.string   "phone"
    t.string   "identity_url"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "carrier",                 :limit => 20
    t.boolean  "email_notification",                    :default => false
    t.boolean  "sms_notification",                      :default => false
    t.boolean  "status_notification",                   :default => false
    t.boolean  "instructor_notification",               :default => false
    t.string   "api_key"
  end

  add_index "users", ["email"], :name => "index_users_on_email"
  add_index "users", ["identity_url"], :name => "index_users_on_identity_url"

  create_table "votes", :force => true do |t|
    t.integer  "user_id"
    t.integer  "voteable_id"
    t.string   "voteable_type"
    t.integer  "points"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "votes", ["points"], :name => "index_votes_on_points"
  add_index "votes", ["user_id"], :name => "index_votes_on_user_id"
  add_index "votes", ["voteable_id", "voteable_type"], :name => "index_votes_on_voteable_id_and_voteable_type"

end
