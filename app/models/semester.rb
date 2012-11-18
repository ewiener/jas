
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
      # No dates that there aren't classes
      return
    end
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
    if ((ptainstructors == nil) or (teachrs == nil))
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
end

