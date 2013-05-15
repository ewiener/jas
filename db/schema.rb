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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130510185506) do

  create_table "courses", :force => true do |t|
    t.text    "name"
    t.text    "description"
    t.boolean "sunday"
    t.boolean "monday"
    t.boolean "tuesday"
    t.boolean "wednesday"
    t.boolean "thursday"
    t.boolean "friday"
    t.boolean "saturday"
    t.text    "start_time"
    t.text    "end_time"
    t.text    "grade_range"
    t.integer "class_min"
    t.integer "class_max"
    t.integer "number_of_classes"
    t.float   "fee_per_meeting"
    t.float   "fee_for_additional_materials"
    t.float   "course_fee"
    t.integer "semester_id"
    t.integer "ptainstructor_id"
    t.integer "teacher_id"
  end

  create_table "courses_students", :id => false, :force => true do |t|
    t.integer "course_id"
    t.integer "student_id"
  end

  create_table "enrollments", :force => true do |t|
    t.integer "dismissal"
    t.integer "scholarship"
    t.float   "scholarship_amount"
    t.boolean "enrolled"
    t.integer "semester_id"
    t.integer "course_id"
    t.integer "student_id"
  end

  create_table "ptainstructors", :force => true do |t|
    t.text    "first_name"
    t.text    "last_name"
    t.text    "email"
    t.text    "phone"
    t.text    "address"
    t.text    "bio"
    t.integer "semester_id"
  end

  create_table "semesters", :force => true do |t|
    t.text  "name"
    t.text  "semester_name"
    t.text  "start_date"
    t.text  "end_date"
    t.text  "dates_with_no_classes"
    t.text  "lottery_deadline"
    t.text  "registration_deadline"
    t.float "fee"
    t.text  "dates_with_no_classes_day"
    t.text  "individual_dates_with_no_classes"
  end

  create_table "sessions", :force => true do |t|
    t.string   "session_id", :null => false
    t.text     "data"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "sessions", ["session_id"], :name => "index_sessions_on_session_id"
  add_index "sessions", ["updated_at"], :name => "index_sessions_on_updated_at"

  create_table "students", :force => true do |t|
    t.text    "first_name"
    t.text    "last_name"
    t.text    "grade"
    t.text    "parent_phone"
    t.text    "parent_phone2"
    t.text    "parent_name"
    t.text    "parent_email"
    t.text    "health_alert"
    t.integer "semester_id"
    t.integer "teacher_id"
  end

  create_table "teachers", :force => true do |t|
    t.text    "name"
    t.text    "grade"
    t.text    "classroom"
    t.integer "semester_id"
  end

  create_table "users", :force => true do |t|
    t.datetime "created_at",                       :null => false
    t.datetime "updated_at",                       :null => false
    t.string   "username",                         :null => false
    t.string   "crypted_password",                 :null => false
    t.string   "password_salt",                    :null => false
    t.string   "persistence_token",                :null => false
    t.integer  "login_count",       :default => 0, :null => false
    t.datetime "last_request_at"
    t.datetime "last_login_at"
    t.datetime "current_login_at"
    t.string   "last_login_ip"
    t.string   "current_login_ip"
  end

  add_index "users", ["last_request_at"], :name => "index_users_on_last_request_at"
  add_index "users", ["persistence_token"], :name => "index_users_on_persistence_token"
  add_index "users", ["username"], :name => "index_users_on_username"

end
