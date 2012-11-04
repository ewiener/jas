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
=begin
                  :start_time_hour,
                  :start_time_minute,
                  :start_time_type,
                  :end_time_hour,
                  :end_time_minute,
                  :end_time_type,
=end
                  :class_min,
                  :class_max,
                  :grade_range,
                  :fee_per_meeting,
                  :fee_for_additional_materials,
                  :total_fee,
                  :semester

  #has location through teacher

  belongs_to :semester
  belongs_to :ptainstructor
  has_many :students
  belongs_to :teacher

=begin
  validates :name, :presence => true
  validates :start_time, :presence => true
  validates :end_time, :presence => true
=end

  validate :name_is_valid
  validate :days_of_week_are_valid
  validate :number_of_classes_is_valid
  validate :start_time_is_valid
  validate :end_time_is_valid
=begin
  validate :start_time_hour_is_valid
  validate :start_time_minute_is_valid
  validate :start_time_type_is_valid
  validate :end_time_hour_is_valid
  validate :end_time_minute_is_valid
  validate :end_time_type_is_valid
=end
  validate :class_min_is_valid
  validate :class_max_is_valid
  #validate :grade_range_is_valid
  validate :fee_per_meeting_is_valid
  validate :fee_for_additional_materials_is_valid
  validate :total_fee_is_valid

  private
  def name_is_valid
    errors.add(:name,'Invalid empty string for name.') unless name_is_valid?
  end

  public
  def name_is_valid?
    return false unless not_nil_and_string(self.name)
    return self.name.length > 0
  end

  private
  def start_time_is_valid
    errors.add(:start_time,'Invalid empty string for start time.') unless start_time_is_valid?
  end

  public
  def start_time_is_valid?
    return false unless not_nil_and_string(self.start_time)
    return self.start_time.length > 0
  end

 private
  def end_time_is_valid
    errors.add(:end_time,'Invalid empty string for end time.') unless end_time_is_valid?
  end

  public
  def end_time_is_valid?
    return false unless not_nil_and_string(self.end_time)
    return self.end_time.length > 0
  end

  private
  def number_of_classes_is_valid
    errors.add(:number_of_classes, 'Invalid number of classes') unless number_of_classes_is_valid?
  end

  public
  def number_of_classes_is_valid?
    return ((self.number_of_classes != nil) and (self.number_of_classes > 0))
  end

  private
  def days_of_week_are_valid
    errors.add(:days_of_week, "The days of the week are invalid.") unless days_of_week_are_valid?
  end

  public
  def days_of_week_are_valid?
    if (self.sunday == nil); return false; end
    if (self.monday == nil); return false; end
    if (self.tuesday == nil); return false; end
    if (self.wednesday == nil); return false; end
    if (self.thursday == nil); return false; end
    if (self.friday == nil); return false; end
    if (self.saturday == nil); return false; end

    if ((self.sunday != true) and (self.sunday != false)); return false; end
    if ((self.monday != true) and (self.monday != false)); return false; end
    if ((self.tuesday != true) and (self.tuesday != false)); return false; end
    if ((self.wednesday != true) and (self.wednesday != false)); return false; end
    if ((self.thursday != true) and (self.thursday != false)); return false; end
    if ((self.friday != true) and (self.friday != false)); return false; end
    if ((self.saturday != true) and (self.saturday != false)); return false; end
    return true
  end

=begin
  private
  def start_time_hour_is_valid
    errors.add(:start_time_hour, 'Invalid starting time hour.') unless start_time_hour_is_valid?
  end

  public
  def start_time_hour_is_valid?
      return hour_valid?(self.start_time_hour, self.start_time_type)
  end

  private
  def start_time_minute_is_valid
    errors.add(:start_time_minute,'Invalid starting time minute.') unless start_time_minute_is_valid?
  end

  public
  def start_time_minute_is_valid?
    return minute_valid?(self.start_time_minute)
  end

  private
  def end_time_hour_is_valid
    errors.add(:end_time_hour, 'Invalid ending time hour.') unless end_time_hour_is_valid?
  end

  public
  def end_time_hour_is_valid?
    return hour_valid?(self.end_time_hour, self.end_time_type)
  end

  private
  def end_time_minute_is_valid
    errors.add(:end_time_minute, 'Invalid ending time minute.') unless end_time_minute_is_valid?
  end

  public
  def end_time_minute_is_valid?
    return minute_valid?(self.end_time_minute)
  end

  private
  def hour_valid?(hour,type)
    case type
    when 0..1
      return HOUR12.include? hour
    when 2
      return HOUR24.include? hour
    end
    return false
  end

  private
  def minute_valid?(minute)
    return MINUTE.include?(minute)
  end

  private
  def start_time_type_is_valid
    errors.add(:start_time_type, 'Invalid start time type.  Should be AM, PM, or 24HR.') unless start_time_type_is_valid?
  end

  public
  def start_time_type_is_valid?
    return TIME_TYPE.include? self.start_time_type
  end

  private
  def end_time_type_is_valid
    errors.add(:end_time_type,'Invalid end time type.  Should be AM, PM, or 24HR.') unless end_time_type_is_valid?
  end

  public
  def end_time_type_is_valid?
    return TIME_TYPE.include? self.end_time_type
  end
=end

  private
  def class_min_is_valid
    errors.add(:class_min,'Invalid class min value.') unless class_min_is_valid?
  end

  public
  def class_min_is_valid?
    if (self.class_min == nil); return false; end
    return ((self.class_min > 0) and (self.class_max >= self.class_min))
  end

  private
  def class_max_is_valid
    errors.add(:class_max,'Invalid class max value.') unless class_max_is_valid?
  end

  public
  def class_max_is_valid?
    if (self.class_max == nil); return false; end
    return ((self.class_max > 0) and (self.class_max >= self.class_min))
  end

  #TODO: Need to define :grade_range_is_valid

  private
  def fee_per_meeting_is_valid
    errors.add(:fee_per_meeting, 'The fee per meeting is invalid.') unless fee_per_meeting_is_valid?
  end

  public
  def fee_per_meeting_is_valid?
    return ((self.fee_per_meeting != nil) and (self.fee_per_meeting >= 0))
  end

  private
  def fee_for_additional_materials_is_valid
    errors.add(:fee_for_additional_materials, 'The fee for additional materials is invalid.') unless fee_for_additional_materials_is_valid?
  end

  public
  def fee_for_additional_materials_is_valid?
    return ((self.fee_for_additional_materials != nil)  and (self.fee_for_additional_materials >= 0))
  end

  private
  def total_fee_is_valid
    errors.add(:total_fee,'The total fee is invalid.') unless total_fee_is_valid?
  end

  public
  def total_fee_is_valid?
    return ((self.total_fee != nil) and (self.total_fee >= 0))
  end

  private
  def not_nil_and_string(str)
    return true unless ((str == nil) or (not str.instance_of? String))
    return false
  end

################################## VALIDATION METHODS END ###########################################

  public
  def class_how_full?
    return [self.students.count, self.class_max]
  end

end
