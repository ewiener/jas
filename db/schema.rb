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

ActiveRecord::Schema.define(:version => 20121021041637) do

  create_table "courses", :force => true do |t|
    t.text    "name"
    t.text    "description"
    t.text    "number_of_classes"
    t.boolean "sunday"
    t.boolean "monday"
    t.boolean "tuesday"
    t.boolean "wednesday"
    t.boolean "thursday"
    t.boolean "friday"
    t.boolean "saturday"
    t.integer "start_time_hour"
    t.integer "start_time_minute"
    t.integer "start_time_type"
    t.integer "end_time_hour"
    t.integer "end_time_minute"
    t.integer "end_time_type"
    t.integer "class_min"
    t.integer "class_max"
    t.text    "grade_range"
    t.float   "fee_per_meeting"
    t.float   "fee_for_additional_materials"
    t.float   "total_fee"
    t.integer "semester_id"
  end

  create_table "semesters", :force => true do |t|
    t.text  "name"
    t.text  "start_date"
    t.text  "end_date"
    t.text  "dates_with_no_classes"
    t.text  "lottery_deadline"
    t.text  "registration_deadline"
    t.float "fee"
  end

  create_table "users", :force => true do |t|
    t.text "username"
    t.text "email"
    t.text "password"
  end

end
