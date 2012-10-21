# PTA Course held within a specific Semester. PTA Instructors and Students belong to a Course.
class Course < ActiveRecord::Base
  require 'time'
  serialize :days_of_week
  TIME_TYPE = [0, 1, 2] # AM, PM, 24HR
  HOUR12 = Array(1..12)
  HOUR24 = Array(0..23)
  MINUTE = Array(0..59)
  attr_accessor :name,
                :description,
                :days_of_week,
                :number_of_classes,
                :start_time_hour,
                :start_time_minute,
                :start_time_type,
                :end_time_hour,
                :end_time_minute,
                :end_time_type,
                :class_min,
                :class_max,
                :grade_range,
                :fee_per_meeting,
                :fee_for_additional_materials,
                :total_fee
                
  attr_accessible :name,
                :description,
                :days_of_week,
                :number_of_classes,
                :start_time_hour,
                :start_time_minute,
                :start_time_type,
                :end_time_hour,
                :end_time_minute,
                :end_time_type,
                :class_min,
                :class_max,
                :grade_range,
                :fee_per_meeting,
                :fee_for_additional_materials,
                :total_fee

  #has location through teacher

  belongs_to :session
  has_many :ptainstructors
  has_many :students

  validate :name_is_valid
  validates :description, :presence => true
  validate :days_of_week_is_valid
  validate :number_of_classes_is_valid
  validate :start_time_hour_is_valid
  validate :start_time_minute_is_valid
  validate :start_time_type_is_valid
  validate :end_time_hour_is_valid
  validate :end_time_minute_is_valid
  validate :end_time_type_is_valid
  #validate :class_min_valid
  #validate :class_max_valid
  validate :grade_range_valid
  validate :fee_per_meeting_is_valid
  validate :fee_for_additional_materials_is_valid
  validate :total_fee_is_valid

  private
  def name_is_valid
    errors.add(:name,'Invalid empty string for name.') unless name_is_valid?
  end

  def name_is_valid?
    return self.name.length > 0
  end

  private
  def days_of_week_is_valid

  end

  def days_of_week_is_valid?

  end

  private
  def number_of_classes_is_valid
    errors.add(:number_of_classes, 'Invalid number of classes') unless number_of_classes_is_valid?
  end

  def number_of_classes_is_valid?
    return self.number_of_classes > 0
  end

  private
  def start_time_hour_is_valid
    errors.add(:start_time_hour, 'Invalid starting time hour.') unless start_time_hour_is_valid?
  end

  def start_time_hour_is_valid?
      return hour_valid?(self.start_time_hour)
  end

  private
  def start_time_minute_is_valid
    errors.add(:start_time_minute,'Invalid starting time minute.') unless start_time_minute_is_valid?
  end

  def start_time_minute_is_valid?
    return minute_valid?(self.end_time_minute)
  end

  private
  def end_time_hour_is_valid
    errors.add(:end_time_hour, 'Invalid ending time hour.') unless end_time_hour_is_valid?
  end

  def end_time_hour_minute_is_valid?
    return hour_valid?(self.end_time_hour)
  end

  private
  def end_time_minute_is_valid
    errors.add(:end_time_minute, 'Invalid ending time minute.') unless end_time_minute_is_valid?
  end

  def end_time_minute_is_valid?
    return minute_valid?(self.end_time_hour)
  end

  private
  def hour_valid?(hour)
    case hour
    when 0..1
      return HOUR12.include? hour
    when 2
      return HOUR24.include? hour
    end
  end

  private
  def minute_valid?(minute)
    return MINUTE.include?(minute)
  end

  private
  def start_time_type_is_valid
    errors.add(:start_time_type, 'Invalid start time type.  Should be AM, PM, or 24HR.') unless start_time_type_is_valid?
  end

  def start_time_type_is_valid?
    return TIME_TYPE.include? self.start_time_type
  end

  private
  def end_time_type_is_valid
    errors.add(:end_time_type,'Invalid end time type.  Should be AM, PM, or 24HR.') unless end_time_type_is_valid?
  end

  def end_time_type_is_valid?
    return TIME_TYPE.include? self.end_time_type
  end

  private
  def class_min_is_valid
    errors.add(:class_min,'Invalid class min value.') unless class_min_is_valid?
  end

  def class_min_is_valid?
    return self.class_min > 0 and self.class_max >= self.class_min
  end

  private
  def class_max_is_valid
    errors.add(:class_max,'Invalid class max value.') unless class_max_is_valid?
  end

  def class_max_is_valid?
    return self.class_max > 0 and self.class_max >= self.class_min
  end

  #TODO: Need to define :grade_range_is_valid

  private
  def fee_for_additional_materials_is_valid
    errors.add(:fee_for_additional_materials, 'The fee for additional materials is invalid.') unless fee_for_additional_materials_is_valid?
  end

  def fee_for_additional_materials_is_valid?
    return self.fee_for_addtional_materials >= 0
  end

  private
  def total_fee_is_valid
    errors.add(:total_fee,'The total fee is invalid.') unless total_fee_is_valid?
  end

  def total_fee_is_valid?
    return self.total_fee >= 0
  end
end
