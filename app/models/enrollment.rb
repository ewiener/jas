class Enrollment < ActiveRecord::Base
  belongs_to :course
  belongs_to :student

  attr_accessible :dismissal,
                  :scholarship,
                  :scholarship_amount,
                  :enrolled,
                  :student_id,
                  :course_id

  validates :dismissal, :numericality => {:only_integer => true, :less_than_or_equal_to => 3}
  validates :scholarship, :numericality => {:only_integer => true, :less_than_or_equal_to => 2}
  validate :scholarship_amount_is_valid
  validate :course_id_is_valid
  validate :student_id_is_valid
  validate :student_not_already_enrolled
  
  scope :enrolled, where(:enrolled => true)
  scope :disenrolled, where(:enrolled => false)
  scope :by_course_day_and_course_name, joins(:course).order("sunday desc, monday desc, tuesday desc, wednesday desc, thursday desc, friday desc, saturday desc, name asc")
  scope :by_course_day_and_course_name_and_student_name, joins(:student).order("sunday desc, monday desc, tuesday desc, wednesday desc, thursday desc, friday desc, saturday desc, name asc, last_name asc, first_name asc")
  scope :by_course_day_and_student_name, joins(:student).order("sunday desc, monday desc, tuesday desc, wednesday desc, thursday desc, friday desc, saturday desc, last_name asc, first_name asc")
  scope :by_course_day_and_grade_and_student_name, joins(:student).order("sunday desc, monday desc, tuesday desc, wednesday desc, thursday desc, friday desc, saturday desc, case when grade = 'K' then '0' else grade end asc, last_name asc, first_name asc")
  scope :by_student_name, joins(:student).order("last_name asc, first_name asc")
  
  scope :with_teacher, lambda {|teacher| teacher.present? ? where(:students => {:classroom_id => teacher}) : {}}
  scope :with_dismissal, lambda {|dismissal| dismissal.present? ? where(:dismissal => dismissal) : {}}

  DISMISSAL = ["Pick Up","JAZ","BEARS","Walk"]
  SCHOLARSHIP = ["None", "Full", "Partial"]
  STATUS = ["Enrolled", "Disenrolled"]
  
  after_initialize do
	  if self.new_record?
      self.scholarship ||= 0
      self.dismissal ||= 0
      self.enrolled ||= true
	  end
	end
	
	after_validation do
		if SCHOLARSHIP[self.scholarship] == "Full"
			self.scholarship_amount = course.total_fee
	  elsif SCHOLARSHIP[self.scholarship] == "None"
		  self.scholarship_amount = 0
		end
	end
	
	def total_fee
  	course.total_fee.to_i - scholarship_amount.to_i
  end
    
  def amount_due
    enrolled ? total_fee : 0
  end
  
  def has_scholarship?
  	self.scholarship > 0
  end

  private
  def scholarship_amount_is_valid
    errors.add(:scholarship_amount, "is invalid.") unless scholarship_amount_is_valid?
  end

  public
  def scholarship_amount_is_valid?
    return true if self.scholarship_amount.nil?
    course = Course.find_by_id(self.course_id)
    return false unless course #make sure course is non-nil
    return ((self.scholarship_amount >= 0) and (self.scholarship_amount <= course.total_fee)) #Make sure the scholarship fee is non-negative and that it is also less than or equal to the total course fee
  end

  private
  def enrolled_is_valid
    errors.add(:enrolled, "is invalid.") unless enrollment_is_valid?
  end

  public
  def enrollment_is_valid?
    return true
  end

  private
  def course_id_is_valid
    errors.add(:course_id, "is missing or invalid.") unless course_id_is_valid?
  end

  public
  def course_id_is_valid?
    return self.course_id? && Course.find_by_id(self.course_id)
  end

  private
  def student_not_already_enrolled
    errors.add(:base, "The student is already enrolled in the selected course.") unless student_not_already_enrolled?
  end

  public
  def student_not_already_enrolled?
    enrollments = Enrollment.where(:student_id => self.student_id, :course_id => self.course_id )
    return enrollments.length == 0 || self.id == enrollments[0].id
  end

  private
  def student_id_is_valid
    errors.add(:student_id, "is missing or invalid.") unless student_id_is_valid?
  end

  public
  def student_id_is_valid?
    return self.student_id? && Student.find_by_id(self.student_id)
  end

  public
  def scholarship_to_s
    if self.scholarship && self.scholarship < SCHOLARSHIP.length
    	return SCHOLARSHIP[self.scholarship]
    end	
  end
  
  def dismissal_to_s
    if self.dismissal && self.dismissal < DISMISSAL.length
    	return DISMISSAL[self.dismissal]
    end
  end
  
  public
  def enrolled_to_s
    return self.enrolled ? STATUS[0] : STATUS[1]
  end

end
