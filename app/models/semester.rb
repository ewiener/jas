
class Semester < ActiveRecord::Base
  require 'date'

  serialize :dates_with_no_classes
  attr_accessor :name, :start_date, :end_date, :dates_with_no_classes, :lottery_deadline, :registration_deadline

  validates :name, :presence => true

  validate :valid_start_date
  validate :valid_end_date
  validate :start_date_before_end_date

  validate :dates_with_no_classes_in_session

  validate :valid_lottery_date
  validate :valid_registration_date

  has_many :courses
  has_many :students, :through => :courses
  has_many :ptainstructors, :through => :courses
  has_many :teachers, :through => :courses

  # Verifies that the start date is not the end date and that it comes before the end date.
  def start_date_before_end_date
    date_start = Date.parse(self.start_date)
    date_end = Date.parse(self.end_date)
    if date_start >= date_end
      errors.add(:start_date, "Start date must be before end date.")
    end
  end

  # Verifies that the start date can be parsed
  def valid_start_date
    begin
      Date.parse(self.start_date)
    rescue
      errors.add(:start_date, 'The start date cannot be parsed.')
    end
  end

  # Verifies that the end date can be parsed
  def valid_end_date
    begin
      Date.parse(self.end_date)
    rescue
      errors.add(:end_date, 'The end date cannot be parsed.')
    end
  end

  # Verifies that the dates that there are no classes are within the session start date and session end date.
  def dates_with_no_classes_in_session
    begin
      begin_parse = Date.parse(self.start_date)
      end_parse = Date.parse(self.end_date)
    rescue
      errors.add(:dates_with_no_classes, 'Could not verify that the dates with no classes fall within the session because the start and/or end dates are not parseable.')
      return
    end
    self.dates_with_no_classes.each do |date|
      begin
        date_parsed = Date.parse(date)
      rescue
        errors.add(:dates_with_no_classes, 'The date, "#{date}", could not be parsed.')
      end
      if date_parsed > end_parsed or date_parsed < start_parsed
        errors.add(:dates_with_no_classes, 'The date, "#{date}", does not reside within the semester.')
      end
    end
  end

  # Verifies that the lottery date can be parsed
  def valid_lottery_date
    begin
      Date.parse(:lottery_deadline)
    rescue
      errors.add(:lottery_deadline, 'The lottery deadline could not be parsed.')
    end
  end

  def valid_registration_date
    begin
      Date.parse(:registration_deadline)
    rescue
      errors.add(:registration_deadline, 'The registration deadline could not be parsed.')
    end
  end

  def USDateParse(date)
    date = Date.strptime(date,'%d/%m/%Y')
  end

end
