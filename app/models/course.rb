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
  #validates :start_time
  #validates :end_time
  validates :class_min, :numericality => {:only_integer => true}, :allow_nil => true
  validates :class_max, :numericality => {:only_integer => true, :greater_than_or_equal_to => :class_min}, :allow_nil => true
  validates :fee_per_meeting, :numericality => true, :allow_nil => true
  validates :fee_for_additional_materials, :numericality => true, :allow_nil => true
  validates :total_fee, :numericality => true, :allow_nil => true
  #validates :ptainstructor
  #validates :teacher
  
  after_validation :calculate_number_of_classes
  
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
  
  def days_of_week
  	daysarr = []
  	daysarr << 1 if monday
  	daysarr << 2 if tuesday
  	daysarr << 3 if wednesday
  	daysarr << 4 if thursday
  	daysarr << 5 if friday
  	daysarr << 6 if saturday
  	daysarr << 7 if sunday
  	daysarr
  end
  
  def abbrev_days
  	days.map {|day| Date.parse(day).strftime("%a")}
  end
  	
  #Returns array with number of students in course and class_max.
  def class_how_full?
    return [self.students.count, self.class_max]
  end
  
	def name_with_grade_level
		course_name = self.name
		if self.grade_range && !self.grade_range.empty?
			course_name << " (" << self.grade_range << ")"
		end
		return course_name
	end
	
	def name_with_day_and_grade_level
		days = abbrev_days.map {|day| day.upcase}.join(",")
		course_name = "#{days}: #{name_with_grade_level}"
	end
	
	def time_range
		"#{self.start_time} - #{self.end_time}"
	end

  def calculate_number_of_classes
    self.number_of_classes = 0
    class_meetings_by_day = semester.specific_days_in_semester
    days_of_week.each do |day_of_week|
      if ((1 <= day_of_week) and (day_of_week <= 7))
        self.number_of_classes += class_meetings_by_day[day_of_week]
      end
    end
  end
end
