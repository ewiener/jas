class Student < ActiveRecord::Base
  belongs_to :semester
  belongs_to :teacher
  has_many :enrollments, :dependent => :destroy
  has_many :courses, :through => :enrollment

  GRADES = ["K","1","2","3","4","5"]

  attr_accessible :first_name,
                  :last_name,
                  :grade,
                  :parent_phone,
                  :parent_phone2,
                  :parent_name,
                  :parent_email,
                  :health_alert,
                  :teacher_id

  validates :first_name, :presence => true
  validates :last_name, :presence => true
  validates_format_of :parent_email, :with => /@/, :allow_blank => true
  validates_format_of :parent_phone, :with => /^\(?([0-9]{3})\)?[-. ]?([0-9]{3})[-. ]?([0-9]{4})$/, :allow_blank => true
  validates_format_of :parent_phone2, :with => /^\(?([0-9]{3})\)?[-. ]?([0-9]{3})[-. ]?([0-9]{4})$/, :allow_blank => true
  validates :grade, :inclusion => { :in => GRADES, :message => 'must be one of ' + GRADES.join(",")}, :allow_blank => true
  
  scope :alphabetical, order("last_name asc, first_name asc")
  default_scope alphabetical

  private
  def grade_is_valid
    errors.add(:grade, 'invalid.') unless grade_is_valid?
  end

  public
  def grade_is_valid?
    if not_nil_and_string(self.grade)
      if GRADES.include? self.grade
        if self.grade == "k";self.grade = "K";end #force uppercase K
        return true
      end
    end
    return false
  end

  private
  #Returns true if not nil and string
  def not_nil_and_string(str)
    return true unless ((str == nil) or (not str.instance_of? String))
    return false
  end

  private
  #Returns true if is nil or empty string
  def is_nil_or_empty_string(str)
    return false unless ((str == nil) or (str == ""))
    return true
  end

  #Formats number
  def formatted_number(number)
    digits = number.gsub(/\D/, '').split(//)

    if (digits.length == 10)
      digits = digits.join
      '(%s) %s-%s' % [ digits[0,3], digits[3,3], digits[6,4] ]
    end
  end

  public
  def full_name
  	"#{first_name} #{last_name}"
  end
  
  def allowable_grades
  	GRADES
  end
  
  def grand_total
    total = enrollments.inject(0) { |sum, enrollment| sum + enrollment.amount_due }
    total > 0 ? total += semester.fee : 0
  end

  def find_enrollment(course_id)
  	enrollments.where(:course_id => course_id).first
  end
  
  def create_enrollment(attrs)
  	enrollments.create(attrs)
  end
end
