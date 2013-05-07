# PTA Course held within a specific Semester. PTA Instructors and Students belong to a Course.

class Course < ActiveRecord::Base
  require 'time'
  serialize :days_of_week
  TIME_TYPE = [0, 1, 2] # AM, PM, 24HR
  HOUR12 = Array(1..12)
  HOUR24 = Array(0..23)
  MINUTE = Array(0..59)

  # Attributes
  attr_accessible :name,
                  :description,
                  :sunday,
                  :monday,
                  :tuesday,
                  :wednesday,
                  :thursday,
                  :friday,
                  :saturday,
                  :number_of_classes,
                  :start_time,
                  :end_time,
                  :class_min,
                  :class_max,
                  :grade_range,
                  :fee_per_meeting,
                  :fee_for_additional_materials,
                  :total_fee,
                  :semester_id,
                  :ptainstructor_id,
                  :teacher_id

  #has location through teacher

  belongs_to :semester
  belongs_to :ptainstructor
  belongs_to :teacher
  has_many :enrollments, :dependent => :destroy
  has_many :students, :through => :enrollments

  validates :name, :presence => true
  validates :number_of_classes, :numericality => true, :allow_nil => true
  #validates :start_time
  #validates :end_time
  validates :class_min, :numericality => {:only_integer => true}, :allow_nil => true
  validates :class_max, :numericality => {:only_integer => true, :greater_than_or_equal_to => :class_min}, :allow_nil => true
  validates :fee_per_meeting, :numericality => true, :allow_nil => true
  validates :fee_for_additional_materials, :numericality => true, :allow_nil => true
  validates :total_fee, :numericality => true, :allow_nil => true
  #validates :ptainstructor
  #validates :teacher
  
  scope :alphabetical_by_day, order("sunday desc, monday desc, tuesday desc, wednesday desc, thursday desc, friday desc, saturday desc, name asc")
  default_scope alphabetical_by_day

  public
  def days
  	daysarr = []
  	daysarr << 'Monday' if monday
  	daysarr << 'Tuesday' if tuesday
  	daysarr << 'Wednesday' if wednesday
  	daysarr << 'Thursday' if thursday
  	daysarr << 'Friday' if friday
  	daysarr << 'Saturday' if saturday
  	daysarr << 'Sunday' if sunday
  	daysarr
  end
  
  def abbrev_days
  	days.map {|day| Date.parse(day).strftime("%a")}
  end
  	
  #Returns array with number of students in course and class_max.
  def class_how_full?
    return [self.students.count, self.class_max]
  end

  def modify_name_for_enrollments(student_id)
    enrolled =  Enrollment.where("student_id = ? AND course_id = ?", student_id, self.id)
    if enrolled.length != 0
      self.name += " (Edit Only)"
    end
  end
end
