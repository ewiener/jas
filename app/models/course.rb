# PTA Course held within a specific Semester. PTA Instructors and Students belong to a Course.

class Course < ActiveRecord::Base
  require 'time'

  TIME_TYPE = [0, 1, 2] # AM, PM, 24HR
  HOUR12 = Array(1..12)
  HOUR24 = Array(0..23)
  MINUTE = Array(0..59)

  belongs_to :semester
  belongs_to :instructor
  belongs_to :classroom
  has_many :enrollments, :dependent => :destroy
  has_many :students, :through => :enrollments

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
                  :start_time,
                  :end_time,
                  :class_min,
                  :class_max,
                  :grade_range,
                  :fee_per_meeting,
                  :fee_for_additional_materials,
                  :course_fee,
                  :instructor_id,
                  :classroom_id,
                  :instructor,
                  :classroom

  attr_accessor :number_of_classes,
                :holidays

  validates :name, :presence => true
  #validates :start_time
  #validates :end_time
  validates :class_min, :numericality => {:only_integer => true}, :allow_nil => true
  validates :class_max, :numericality => {:only_integer => true, :greater_than_or_equal_to => :class_min}, :allow_nil => true
  validates :fee_per_meeting, :numericality => true, :allow_nil => true
  validates :fee_for_additional_materials, :numericality => true, :allow_nil => true
  validates :course_fee, :numericality => true, :allow_nil => true
  #validates :instructor
  #validates :classroom

  after_validation :calc_number_of_classes_and_holidays
  after_initialize :calc_number_of_classes_and_holidays

  scope :by_day_and_name, order("sunday desc, monday desc, tuesday desc, wednesday desc, thursday desc, friday desc, saturday desc, name asc")

  def total_fee
  	self.course_fee.to_i + (self.number_of_classes.to_i * self.fee_per_meeting.to_i) + self.fee_for_additional_materials.to_i
  end

  def days
  	daysarr = Array.new
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
  	daysarr = Array.new
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

  def abbrev_days_as_string
    abbrev_days.join(",")
  end

  #Returns array with number of students in course and class_max.
  def class_how_full?
    return [self.students.count, self.class_max]
  end

  def num_total_enrollments
  	return enrollments.count
  end

  def num_valid_enrollments
  	return enrollments.enrolled.count
  end

  def num_scholarship_enrollments
    return enrollments.enrolled.with_scholarship.count
  end

  def full?
  	return self.class_max && self.num_valid_enrollments == self.class_max
  end

  def overenrolled?
  	return self.class_max && self.num_valid_enrollments > self.class_max
  end

  def overenrolled_by
  	return self.class_max ? [self.num_valid_enrollments - self.class_max, 0].max : 0
  end

  def underenrolled?
  	return self.class_min && self.num_valid_enrollments < self.class_min
  end

  def underenrolled_by
  	return self.class_min ? [self.class_min - self.num_valid_enrollments, 0].max : 0
  end

  def name_with_grade_level
		course_name = String.new(self.name)
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
		if self.start_time || self.end_time
		  "#{self.start_time} - #{self.end_time}"
		else
			""
	  end
	end

	def class_min_max_range
		if self.class_min || self.class_max
		  "#{self.class_min} - #{self.class_max}"
		else
			""
		end
	end

  def calc_number_of_classes_and_holidays
    num_classes = 0
    dates_without_classes = Array.new
    begin
	    class_meetings_by_day = semester.num_days_by_day_of_week
	    holidays_by_day = semester.days_off_by_day_of_week
	    days_of_week.each do |day_of_week|
	      if 1 <= day_of_week && day_of_week <= 7
	        num_classes += class_meetings_by_day[day_of_week]
	        dates_without_classes += holidays_by_day[day_of_week]
	      end
	    end
	    dates_without_classes.sort!
	  rescue
	  end
    self.number_of_classes = num_classes
    self.holidays = dates_without_classes
  end

  # special case method to check if the grade range includes kindergarten
  def allows_kindergarten
    self.grade_range.include? 'K'
  end

  # special case method to check if the grade range is only kindergarten
  def only_kindergarten
    self.grade_range == 'K'
  end
end
