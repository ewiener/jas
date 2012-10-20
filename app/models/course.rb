# PTA Course held within a specific Semester. PTA Instructors and Students belong to a Course.
class Course < ActiveRecord::Base
  belongs_to :session
  has_many :ptainstructors
  has_many :students

end
