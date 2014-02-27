class Semester < ActiveRecord::Base
  require 'date'

  has_many :courses, :dependent => :destroy
  has_many :students, :dependent => :destroy
  has_many :instructors, :dependent => :destroy
  has_many :classrooms, :dependent => :destroy
  has_many :enrollments, :through => :courses
  belongs_to :program

  serialize :dates_with_no_classes

  attr_accessible :name,
                  :start_date,
                  :end_date,
                  :dates_with_no_classes,
                  :lottery_deadline,
                  :registration_deadline,
                  :fee,
                  :dates_with_no_classes_day,
                  :district_surcharge,
                  :registration_fees_waived,
                  :instructor_scholarships

  attr_accessor :dates_with_no_classes_day,
                :individual_dates_with_no_classes,
                :num_days_by_day_of_week,
                :days_off_by_day_of_week

  validates :name, :presence => true
  validate :valid_start_date
  validate :valid_end_date
  validate :start_date_before_end_date
  validate :valid_lottery_date
  validate :valid_registration_date

  after_validation do
  	self.start_date = start_date_as_date.strftime("%m/%d/%Y")
    self.end_date = end_date_as_date.strftime("%m/%d/%Y")
    self.dates_with_no_classes ||= []
    calc_individual_days_off
    calc_data_by_day_of_week
  end

  after_initialize do
  	self.dates_with_no_classes ||= []
  	calc_individual_days_off
  	calc_data_by_day_of_week
  end

  def reports
  	init_reports
  	@reports
  end

  def find_report(id)
  	self.reports.find {|report| report.id == id}
  end

  def find_report_by_name(name)
  	self.reports.find {|report| report.name == name}
  end

  private
  # Verifies that the start date comes before the end date and returns true or false
  def start_date_before_end_date
    begin
      date_start = USDateParse(self.start_date)
      date_end = USDateParse(self.end_date)
    rescue
      return
    end
    if date_start >= date_end
      errors.add(:start_date, "must be before end date.")
    end
  end

  private
  # Used by validation check to verify that the start date can be parsed
  def valid_start_date
    errors.add(:start_date, 'invalid.') unless start_date_is_valid?
  end

  public
  # Verifies that the start date can be parsed and returns true or false
  def start_date_is_valid?
    begin
      date = USDateParse(self.start_date)
    rescue
      return false
    end
    return true
  end

  private
  # Used by validation check to verify that the end date can be parsed
  def valid_end_date
    errors.add(:end_date, 'invalid.') unless end_date_is_valid?
  end

  public
  # Verifies that the end date can be parsed and returns true or false
  def end_date_is_valid?
    begin
      date = USDateParse(self.end_date)
    rescue
      return false
    end
    return true
  end

  public
  # Verifies the date range can be parsed (works for single date and range of the form date-date
  def valid_date_span?(date_span)
  	begin
  		parse_dates_from_span(date_span)
    rescue
    	return false
    end
    return true
  end

  private
  # Verifies that the lottery date can be parsed
  def valid_lottery_date
  	return true if self.lottery_deadline.nil? || self.lottery_deadline.empty?
    begin
      USDateParse(self.lottery_deadline)
    rescue
      errors.add(:lottery_deadline, 'invalid.')
    end
  end

  private
  # Used by the validation check to make sure that the registration date can be parsed.
  def valid_registration_date
    errors.add(:registration_deadline, 'invalid.') unless registration_date_is_valid?
  end

  public
  # Verifies that the registration date can be parsed and returns true or false
  def registration_date_is_valid?
  	return true if self.registration_deadline.nil? || self.registration_deadline.empty?
    begin
      USDateParse(self.registration_deadline)
    rescue
      return false
    end
    return true
  end

  private
  # Verifies that the date can be parsed
  # It checks that the date is between January 1, 2000 and January 1, 2100
  def USDateParse(date)
    if (date == nil); raise 'Nil date'; end
    date = Date.strptime(date,'%m/%d/%Y')
    year_2000 = Date.new(2000,1,1)
    year_2100 = Date.new(2100,1,1)
    if date <= year_2000 or date >= year_2100
      date = date + 2000.years
      if date <= year_2000 or date >= year_2100
        raise "Invalid Date"
      end
    end
    return date
  end

  public
  #Tests that instructor and classroom exist before creating course and returns true or false
  def can_create_course?
    instructors = Instructor.find_by_semester_id(self.id)
    classrooms = Classroom.find_by_semester_id(self.id)
    if ((instructors == nil) or (classrooms == nil))
        return false
    end
    return true
  end

  public
  #Returns start_date as date object
  def start_date_as_date
    return USDateParse(self.start_date)
  end

  #Returns start_date as date object
  def end_date_as_date
    return USDateParse(self.end_date)
  end

  private
  #Returns true if not nil and string
  def not_nil_and_string(str)
    return !str.nil? && str.instance_of?(String)
  end

  public
  #Removes date from holiday array and makes it a school day
  def delete_date(date)
    if self.dates_with_no_classes && self.dates_with_no_classes.delete(date)
      if not self.save
      	return false
      end

      # Update holidays and counts by day of week
    	calc_individual_days_off
      calc_data_by_day_of_week
    end
    return true
  end

  private
  def calc_individual_days_off
  	individual_dates = []
  	if dates_with_no_classes
	  	dates_with_no_classes.each do |date_span|
	  		individual_dates += parse_dates_from_span(date_span)
	  	end
	  end
	  self.individual_dates_with_no_classes = individual_dates
  end

  # Returns array of individual dates parsed from a single date or date span like:
  #   11/23/2013 or
  #   11/23/2013-11/25/2013
  def parse_dates_from_span(date_span)
  	dates = Array.new
    dates_array = date_span.split("-")
    start_range = USDateParse(dates_array[0])
    dates << start_range
    if dates_array.length == 2
      end_range = USDateParse(dates_array[1])
      if end_range < start_range
        raise 'End date is before start date'
      end
      date = start_range + 1
      while date <= end_range
        dates << date
        date += 1
      end
    elsif dates_array.length > 2
      raise 'More than one date range'
    end
    return dates
  end

  def calc_data_by_day_of_week
    count_by_day = Hash.new(0)
    days_off_by_day = Hash.new { |hash, key| hash[key] = Array.new }

    begin
	    date_start = start_date_as_date
	    date_end = end_date_as_date
	    curr_date = date_start
	    while curr_date <= date_end do
	      if self.individual_dates_with_no_classes.include?(curr_date)
	      	days_off_by_day[curr_date.cwday] << curr_date
	      else
	        count_by_day[curr_date.cwday] += 1
	      end
	      curr_date += 1
	    end
	  rescue
	  end

    self.num_days_by_day_of_week = count_by_day
    self.days_off_by_day_of_week = days_off_by_day
  end

  def init_reports
  	if self.id && (@reports.nil? || @reports.empty?)
	  	@reports = [
	  		InstructorFeeReport.new(self, 1),
	  		ScholarshipReport.new(self, 2),
	  		RefundReport.new(self, 3),
	  		BalanceReport.new(self, 4)
  	  ]
  	elsif @reports.nil?
  		@reports = []
    end
  end

  public
  # Copies instructors, students, classrooms and courses from 'semester' to this semester
  def import(semester)
    return false if !semester

    self.district_surcharge = semester.district_surcharge

	  imported_objs = {
    	classrooms: Hash.new,
    	courses: Hash.new,
    	instructors: Hash.new,
    	students: Hash.new
    }

    begin
	    ActiveRecord::Base.transaction do
	      semester.courses.each do |course|
	      	import_course(course, imported_objs)
	      end
	      semester.instructors.each do |instructor|
	      	import_instructor(instructor, imported_objs)
	      end
	      semester.classrooms.each do |classroom|
	      	import_classroom(classroom, imported_objs)
	      end
	      semester.students.each do |student|
	      	import_student(student, imported_objs)
	      end
	    end
	  rescue Exception => ex
	  	logger.error("Failed importing session #{semester.name}: #{ex.message}")
	  	errors.add(:base, "Failed to import session #{semester.name}")
    	return false
	  end

	  return true
  end

  private
  def import_course(course, imported_objs)
  	return nil if !course

    new_course = imported_objs[:courses][course.id]
    if !new_course
	    new_course = course.dup
      new_course.semester = self
      if course.classroom
        new_course.classroom = import_classroom(course.classroom, imported_objs)
      end
      if course.instructor
        new_course.instructor = import_instructor(course.instructor, imported_objs)
      end
      new_course.save!
      imported_objs[:courses][course.id] = new_course
    end
    return new_course
  end

  private
  def import_classroom(classroom, imported_objs)
  	return nil if !classroom

  	new_classroom = imported_objs[:classrooms][classroom.id]
    if !new_classroom
      new_classroom = classroom.dup
      new_classroom.semester = self
      new_classroom.save!
      imported_objs[:classrooms][classroom.id] = new_classroom
    end
    return new_classroom
  end

  private
  def import_instructor(instructor, imported_objs)
  	return nil if !instructor

    new_instructor = imported_objs[:instructors][instructor.id]
    if !new_instructor
      new_instructor = instructor.dup
      new_instructor.semester = self
      new_instructor.save!
      imported_objs[:instructors][instructor.id] = new_instructor
    end
    return new_instructor
  end

  private
  def import_student(student, imported_objs)
  	return nil if !student

    new_student = imported_objs[:students][student.id]
    if !new_student
	    new_student = student.dup
	    new_student.semester = self
	    if student.classroom
	      new_student.classroom = import_classroom(student.classroom, imported_objs)
	    end
      new_student.save!
      imported_objs[:students][student.id] = new_student
    end
    return new_student
  end
end

