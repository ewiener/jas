# PTA Course held within a specific Semester.
# PTA Course held within a specific Semester.
# PTA Course held within a specific Semester.
# PTA Course held within a specific Semester.
# PTA Course held within a specific Semester:
# * asdfasdf
# * asdfasdfasdf
# * asdfasdfa
class Course < ActiveRecord::Base
  serialize :days_of_week
  attr_accessor :name, :description, :days_of_week, :number_of_classes, :start_time, :end_time, :class_min, :class_max, :grade_range, :fee_per_meeting, :fee_for_additional_materials, :total_fee

  #has location through teacher


  belongs_to :session
  has_many :ptainstructors
  has_many :students

end
