
class Semester < ActiveRecord::Base
  require 'date'

  has_many :courses, :dependent => :destroy
  has_many :students, :dependent => :destroy
  has_many :ptainstructors, :dependent => :destroy
  has_many :teachers, :dependent => :destroy
  has_many :enrollments, :through => :courses

  serialize :dates_with_no_classes
  serialize :individual_dates_with_no_classes

  attr_accessible :name,
                  :start_date,
                  :end_date,
                  :dates_with_no_classes,
                  :lottery_deadline,
                  :registration_deadline,
                  :fee,
                  :individual_dates_with_no_classes,
                  :dates_with_no_classes_day
                  
  attr_accessor :num_days_by_day_of_week,
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
    dates_with_no_classes ||= Array.new
    calc_individual_days_off
    calc_data_by_day_of_week
  end
  
  after_initialize do
  	calc_data_by_day_of_week
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
  #Tests that ptainstructor and teacher exist before creating course and returns true or false
  def can_create_course?
    ptainstructors = Ptainstructor.find_by_semester_id(self.id)
    teachers = Teacher.find_by_semester_id(self.id)
    if ((ptainstructors == nil) or (teachers == nil))
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
    if self.dates_with_no_classes.delete(date) == nil
      errors.add(:dates_with_no_classes, 'not found.')
      return false
    else
      dates_array = date.split("-")
      start_range = dates_array[0]
      end_range = dates_array[dates_array.length-1]
      date_start = USDateParse(start_range)
      date_end = USDateParse(end_range)
      curr_date = date_start
      while curr_date <= date_end do
        self.individual_dates_with_no_classes.delete(curr_date)
        curr_date += 1
      end
    end
    if not self.save
    	return false
    end
    
    # Update holidays and counts by day of week
    calc_data_by_day_of_week
    
    return true
  end
  
  private
  def calc_individual_days_off
  	dates_with_no_classes.each do |date_span|
  		self.individual_dates_with_no_classes += parse_dates_from_span(date_span)
  	end
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

  public
  #Transfers ptainstructors, students, and courses from one semester to another semester
  def import(semester_to_import)
    if not semester_to_import
      errors.add(:semester_to_import,"Was given a nil semester to import.")
      return false
    end

    failure = false
    error_message = nil
    #raise ActiveRecord::Rollback

    ActiveRecord::Base.transaction do
      ptainstructors = Ptainstructor.find_all_by_semester_id(semester_to_import.id)
      teachers = Teacher.find_all_by_semester_id(semester_to_import.id)
      students = Student.find_all_by_semester_id(semester_to_import.id)
      courses = Course.find_all_by_semester_id(semester_to_import.id)

      ptainstructors_cloned = Hash.new
      teachers_cloned = Hash.new
      courses.each do |oldcourse|
        newcourse = oldcourse.dup
        oldteacher = Teacher.find_by_id(oldcourse.teacher_id)
        oldptainstructor = Ptainstructor.find_by_id(oldcourse.ptainstructor_id)
        raise ActiveRecord::Rollback unless duplicate_teacher_for_course(newcourse, oldteacher,teachers_cloned)
        raise ActiveRecord::Rollback unless duplicate_ptainstructor_for_course(newcourse,oldptainstructor,ptainstructors_cloned)
        newcourse.semester_id = self.id
        raise ActiveRecord::Rollback unless newcourse.save
      end

      ptainstructors.each do |ptainstructor|
        if ptainstructors_cloned[ptainstructor.id];next;end
        raise ActiveRecord::Rollback unless duplicate_ptainstructor(ptainstructor)
      end

      teachers.each do |teacher|
        if teachers_cloned[teacher.id];next;end
        raise ActiveRecord::Rollback unless duplicate_teacher(teacher,teachers_cloned)
      end

      students.each do |student|
        raise ActiveRecord::Rollback unless duplicate_student(student,teachers_cloned)
      end
    end
  end

  private
  #Copies teacher for new course
  def duplicate_teacher_for_course(newcourse, oldteacher, teachers_cloned)
    if teachers_cloned[oldteacher.id]
      newcourse.teacher_id = teachers_cloned[oldteacher.id]
    else
      newteacher = oldteacher.dup
      newteacher.semester_id = self.id
      return false unless newteacher.save
      newcourse.teacher_id = newteacher.id
      teachers_cloned[oldteacher.id] = newteacher.id
    end
    return true
  end

  private
  #Copies ptainstructor for new course
  def duplicate_ptainstructor_for_course(newcourse, oldptainstructor, ptainstructors_cloned)
    if ptainstructors_cloned[oldptainstructor.id]
      newcourse.ptainstructor_id = ptainstructors_cloned[oldptainstructor.id]
    else
      newptainstructor = oldptainstructor.dup
      newptainstructor.semester_id = self.id
      return false unless newptainstructor.save
      newcourse.ptainstructor_id = newptainstructor.id
      ptainstructors_cloned[oldptainstructor.id] = newptainstructor.id
    end
    return true
  end

  private
  #Copies teacher to semester
  def duplicate_teacher(oldteacher,teachers_cloned)
    newteacher = oldteacher.dup
    newteacher.semester_id = self.id
    return false unless newteacher.save
    teachers_cloned[oldteacher.id] = newteacher.id
    return true
  end

  private
  #Copies ptainstructor to semester
  def duplicate_ptainstructor(oldptainstructor)
    newptainstructor = oldptainstructor.dup
    newptainstructor.semester_id = self.id
    return false unless newptainstructor.save
    return true
  end

  private
  #Copies student to semester
  def duplicate_student(oldstudent, teachers_cloned)
    newstudent = oldstudent.dup
    newstudent.semester_id = self.id
    newstudent.teacher_id = teachers_cloned[oldstudent.id]
    return false unless newstudent.save
    return true
  end
end

