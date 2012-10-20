class Semester < ActiveRecord::Base
  serialize :dates_with_no_classes
  attr_accessor :name, :start_date, :end_date, :dates_with_no_classes, :lottery_deadline, :registration_deadline

  has_many :courses
  has_many :students, :through => :courses
  has_many :ptainstructors, :through => :courses
  has_many :teachers, :through => :courses
end
