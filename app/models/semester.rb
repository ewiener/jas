
class Semester < ActiveRecord::Base
  require 'date'

  serialize :dates_with_no_classes

  # Attributes
  # :name, :start_date
  attr_accessible :name,
                  :start_date,
                  :end_date,
                  :dates_with_no_classes,
                  :lottery_deadline,
                  :registration_deadline,
                  :fee
                  #:start_date_as_date

  validate :name_is_valid

  validate :valid_start_date
  validate :valid_end_date
  validate :start_date_before_end_date

  validate :dates_with_no_classes_in_session

  validate :valid_lottery_date
  validate :valid_registration_date



  has_many :courses
  has_many :students, :through => :courses
  has_many :ptainstructors
  has_many :teachers#, :through => :courses

  #TODO Validate fee
  private
  # Used by validation check to verify that the name is valid
  def name_is_valid
    errors.add(:name,"Invalid string for name.") unless name_is_valid?
  end

  public
  # Verifies that the name is valid
  def name_is_valid?
    return false unless not_nil_and_string(self.name)
    return self.name.length > 0
  end

  private
  # Verifies that the start date comes before the end date
  def start_date_before_end_date
    begin
      date_start = USDateParse(self.start_date)
      date_end = USDateParse(self.end_date)
    rescue
      errors.add(:start_date, 'Could not verify that the start date is before the end date because the start and/or end dates are not parsable.')
      return
    end
    if date_start >= date_end
      errors.add(:start_date, "Start date must be before end date.")
    end
  end

  private
  # Used by validation check to verify that the start date can be parsed
  def valid_start_date
    errors.add(:start_date, 'The start date cannot be parsed.') unless start_date_is_valid?
  end

  public
  # Verifies that the start date can be parsed
  def start_date_is_valid?
    begin
      date = USDateParse(self.start_date)
      self.start_date = date.strftime("%m/%d/%y")
    rescue
      return false
    end
    return true
  end

  private
  # Used by validation check to verify that the end date can be parsed
  def valid_end_date
    errors.add(:end_date, 'The end date cannot be parsed.') unless end_date_is_valid?
  end

  public
  # Verifies that the end date can be parsed
  def end_date_is_valid?
    begin
      date = USDateParse(self.end_date)
      self.end_date = date.strftime("%m/%d/%y")
    rescue
      return false
    end
    return true
  end

  private
  # Verifies that the dates that there are no classes are within the session start date and session end date.
  def dates_with_no_classes_in_session
    if self.dates_with_no_classes == nil
      # No dates that there aren't classes, initialize with emptylist
      self.dates_with_no_classes = []
      return
    end
=begin
    begin
      begin_parse = USDateParse(self.start_date)
      end_parse = USDateParse(self.end_date)
    rescue
      errors.add(:dates_with_no_classes, 'Could not verify that the dates with no classes fall within the session because the start and/or end dates are not parseable.')
      return
    end
    self.dates_with_no_classes.each do |date|
      begin
        date_parsed = USDateParse(date)
      rescue
        errors.add(:dates_with_no_classes, 'The date, "#{date}", could not be parsed.')
      end
      if date_parsed > end_parse or date_parsed < begin_parse
        errors.add(:dates_with_no_classes, 'The date, "#{date}", does not reside within the semester.')
      end
    end
=end
  end

  private
  # Verifies that the lottery date can be parsed
  def valid_lottery_date
    begin
      USDateParse(self.lottery_deadline)
    rescue
      errors.add(:lottery_deadline, 'The lottery deadline could not be parsed.')
    end
  end

  private

  # Used by the validation check to make sure that the registration date can be parsed.
  def valid_registration_date
    errors.add(:registration_deadline, 'The registration deadline could not be parsed.') unless registration_date_is_valid?
  end

  public
  # Verifies that the registration date can be parsed
  def registration_date_is_valid?
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
  def can_create_course?
    ptainstructors = Ptainstructor.find_by_semester(self.id)
    teachers = Teacher.find_by_semester(self.id)
    if ((ptainstructors == nil) or (teachers == nil))
        return false
    end
    return true
  end

  public
  def start_date_as_date
    return USDateParse(self.start_date)
  end

  private
  def not_nil_and_string(str)
    return true unless ((str == nil) or (not str.instance_of? String))
    return false
  end

  public
  #returns a hash 0f 1-7, where 1 is monday
  def specific_days_in_semester(start_date, end_date)
    date_start = USDateParse(start_date)#USDateParse(self.start_date)
    date_end = USDateParse(end_date)#USDateParse(self.end_date)
    curr_date = date_start
    date_hash = Hash.new(0)
    while curr_date <= date_end do
      date_hash[curr_date.cwday] += 1
      curr_date += 1
    end
    return date_hash
  end

  public
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
  def duplicate_teacher(oldteacher,teachers_cloned)
    newteacher = oldteacher.dup
    newteacher.semester_id = self.id
    return false unless newteacher.save
    teachers_cloned[oldteacher.id] = newteacher.id
    return true
  end

  private
  def duplicate_ptainstructor(oldptainstructor)
    newptainstructor = oldptainstructor.dup
    newptainstructor.semester_id = self.id
    return false unless newptainstructor.save
    return true
  end

  private
  def duplicate_student(oldstudent, teachers_cloned)
    newstudent = oldstudent.dup
    newstudent.semester_id = self.id
    newstudent.teacher_id = teachers_cloned[oldstudent.id]
    return false unless newstudent.save
    return true
  end
end

