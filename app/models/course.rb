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
                  :semester,
                  :ptainstructor_id,
                  :teacher_id,
                  :ptainstructor,
                  :teacher

  #has location through teacher

  belongs_to :semester
  belongs_to :ptainstructor
  belongs_to :teacher
  has_many :enrollments, :dependent => :destroy
  has_many :students, :through => :enrollments

  validate :name_is_valid
  validate :days_of_week_are_valid
  validate :number_of_classes_is_valid
  validate :start_time_is_valid
  validate :end_time_is_valid

  validate :class_min_is_valid
  validate :class_max_is_valid
  validate :fee_per_meeting_is_valid
  validate :fee_for_additional_materials_is_valid
  validate :total_fee_is_valid
  validate :ptainstructor_is_valid
  validate :teacher_is_valid
  
  scope :alphabetical_by_day, order("sunday desc, monday desc, tuesday desc, wednesday desc, thursday desc, friday desc, saturday desc, name asc")
  default_scope alphabetical_by_day

  private
  #Add errors if name_is_valid? returns false
  def name_is_valid
    errors.add(:name,'Invalid empty string for name.') unless name_is_valid?
  end


  public
  #Tests if the name of course is not nil and is a string and returns true or false.
  def name_is_valid?
    return false unless not_nil_and_string(self.name)
    return self.name.length > 0
  end


  private
  #Add errors if start_time_is_valid? return false
  def start_time_is_valid
    errors.add(:start_time,'Invalid empty string for start time.') unless start_time_is_valid?
  end


  public
  #Tests if start_time of course is not nil and a string and returns true or false.
  def start_time_is_valid?
    return false unless not_nil_and_string(self.start_time)
    return self.start_time.length > 0
  end


 private
  #Adds errors if end_time_is_valid? returns false
  def end_time_is_valid
    errors.add(:end_time,'Invalid empty string for end time.') unless end_time_is_valid?
  end


  public
  #Tests if end_time of course is not nil and a string and returns true or false
  def end_time_is_valid?
    return false unless not_nil_and_string(self.end_time)
    return self.end_time.length > 0
  end

  private
  #Adds errors if number_of_classes_is_valid? returns false
  def number_of_classes_is_valid
    errors.add(:number_of_classes, 'Invalid number of classes') unless number_of_classes_is_valid?
  end


  public
  #Tests if number_of_classes for course is not nil and is greater than 0 and returns true or false.
  def number_of_classes_is_valid?
    return ((self.number_of_classes != nil) and (self.number_of_classes > 0))
  end

  private
  #Adds errors if days_of_week_are_valid? returns false
  def days_of_week_are_valid
    errors.add(:days_of_week, "The days of the week are invalid.") unless days_of_week_are_valid?
  end


  public
  #Tests that none of the days for course are nil and that the days's values are either true or false and returns true or false.
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

  private
  #Adds errors if class_min_is_valid? returns false
  def class_min_is_valid
    errors.add(:class_min,'Invalid class min value.') unless class_min_is_valid?
  end


  public
  #Tests that class_min is not nil or that the class_max has not been set. It checks that the class_min is greater than 0 and that the class_max is greater than the class_min. It returns true or false.
  def class_min_is_valid?
    if ((self.class_min == nil) or (self.class_max == nil)); return false; end
    return ((self.class_min > 0) and (self.class_max >= self.class_min))
  end

  private
  #Adds errors if class_max_is_valid? returns false
  def class_max_is_valid
    errors.add(:class_max,'Invalid class max value.') unless class_max_is_valid?
  end


  public
  #Tests that class_max is not nil or that the class_min has not been set. It checks that the class_max is greater than 0 and that the class_max is greater than the class_min. It returns true or false.
  def class_max_is_valid?
    if ((self.class_max == nil) or (self.class_min == nil)); return false; end
    return ((self.class_max > 0) and (self.class_max >= self.class_min))
  end

  #TODO: Need to define :grade_range_is_valid

  private
  #Adds errors if fee_per_meeting_is_valid? returns false
  def fee_per_meeting_is_valid
    errors.add(:fee_per_meeting, 'The fee per meeting is invalid.') unless fee_per_meeting_is_valid?
  end


  public
  #Tests that the fee_per_meeting for course is not nil and greater than or equal to 0 and returns true or false.
  def fee_per_meeting_is_valid?
    return ((self.fee_per_meeting != nil) and (self.fee_per_meeting >= 0))
  end

  private
  #Adds errors if fee_for_additional_materials returns false
  def fee_for_additional_materials_is_valid
    errors.add(:fee_for_additional_materials, 'The fee for additional materials is invalid.') unless fee_for_additional_materials_is_valid?
  end


  public
  #Tests that fee_for_additional_material for course is not nil and greater than or equal to 0 and returns true or false.
  def fee_for_additional_materials_is_valid?
    return ((self.fee_for_additional_materials != nil)  and (self.fee_for_additional_materials >= 0))
  end

  private
  #Adds errors if total_fee_is_valid? returns false
  def total_fee_is_valid
    errors.add(:total_fee,'The total fee is invalid.') unless total_fee_is_valid?
  end


  public
   #Tests that course's total_fee is not nil and is greater than or equal to 0 and returns true or false.
  def total_fee_is_valid?
    return ((self.total_fee != nil) and (self.total_fee >= 0))
  end

  private
  #Adds errors if ptainstructor_is_valid? returns false
  def ptainstructor_is_valid
    errors.add(:ptainstructor,'No PTA instructor was selected.') unless ptainstructor_is_valid?
  end


  public
  #Tests that the course's ptainstructor_id is not nil and returns true or false.
  def ptainstructor_is_valid?
    return self.ptainstructor_id != nil
  end

  private
  #Adds errors if teacher_is_valid? returns false
  def teacher_is_valid
    errors.add(:teacher,'No classroom location was selected.') unless teacher_is_valid?
  end


  public
  #Tests that the course's teacher_id is not nil and returns true or false.
  def teacher_is_valid?
    return self.teacher_id != nil
  end

  private
  #Returns true if not nil and a string
  def not_nil_and_string(str)
    return true unless ((str == nil) or (not str.instance_of? String))
    return false
  end

################################## VALIDATION METHODS END ###########################################


  public
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
