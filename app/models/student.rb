class Student < ActiveRecord::Base
  belongs_to :semester
  belongs_to :classroom
  has_many :enrollments, :dependent => :destroy
  has_many :courses, :through => :enrollments

  GRADES = ["K","1","2","3","4","5"]

  attr_accessible :first_name,
                  :last_name,
                  :grade,
                  :parent_phone,
                  :parent_phone2,
                  :parent_name,
                  :parent_email,
                  :health_alert,
                  :classroom_id,
                  :classroom

  validates :first_name, :presence => true
  validates :last_name, :presence => true
  validates_format_of :parent_email, :with => /@/, :allow_blank => true
  validates_format_of :parent_phone, :with => /^\(?([0-9]{3})\)?[-. ]?([0-9]{3})[-. ]?([0-9]{4})$/, :allow_blank => true
  validates_format_of :parent_phone2, :with => /^\(?([0-9]{3})\)?[-. ]?([0-9]{3})[-. ]?([0-9]{4})$/, :allow_blank => true
  validates :grade, :inclusion => { :in => GRADES, :message => 'must be one of ' + GRADES.join(",")}, :allow_blank => true
  
  scope :by_name, order("last_name asc, first_name asc")

  #Formats number
  def formatted_number(number)
    digits = number.gsub(/\D/, '').split(//)

    if (digits.length == 10)
      digits = digits.join
      '(%s) %s-%s' % [ digits[0,3], digits[3,3], digits[6,4] ]
    end
  end

  def full_name
  	"#{first_name} #{last_name}"
  end
  
  def allowable_grades
  	GRADES
  end
  
  def grand_total
    total = 0
    if enrollments.count > 0
      total += enrollments.inject(0) { |sum, enrollment| sum + enrollment.amount_due }
      total += semester.fee
    end
    return total
  end
  
  def enrolled?
  	num_valid_enrollments > 0
  end
  
  def num_valid_enrollments
  	enrollments.enrolled.count
  end

  def find_enrollment(course)
  	enrollments.where(:course_id => course.id).first
  end
  
  def has_enrollment(course)
  	enrollments.where(:course_id => course.id).any?
  end
  
  def create_enrollment(attrs)
  	enrollments.create(attrs)
  end
end
