class Enrollment < ActiveRecord::Base
  belongs_to :semester
  belongs_to :course
  belongs_to :student

  attr_accessible :dismissal,
                  :scholarship,
                  :scholarship_amount,
                  :enrolled,
                  :semester_id,
                  :course_id,
                  :student_id

  validate :dismissal_is_valid
  validate :scholarship_is_valid
  validate :scholarship_amount_is_valid
  validate :enrolled_is_valid
  validate :course_id_is_valid
  validate :student_id_is_valid
  validate :student_not_already_enrolled
  
  scope :by_course_day_and_name, joins(:course).order("sunday desc, monday desc, tuesday desc, wednesday desc, thursday desc, friday desc, saturday desc, name asc")

  DISMISSAL = ["Pick Up","JAZ","BEARS","Walk"]
  
  def total_fee
  	course.total_fee - scholarship_amount
  end
    
  def amount_due
    enrolled ? total_fee : 0
  end
  
  private
  #Adds errors if dismisal_is_valid returns false
  def dismissal_is_valid
    errors.add(:dismissal, 'Invalid dismissal value.') unless dismissal_is_valid?
  end

  public
  #Tests that enrollment's dismissal is not nil and is between 0 and 3. Returns true or false
  def dismissal_is_valid?
    return false unless self.dismissal != nil
    return ((self.dismissal >= 0) and (self.dismissal <= 3))
  end

  private
  #Adds errors if scholarship_is_valid? returns false
  def scholarship_is_valid
    errors.add(:scholarship, "Invalid scholarship type was selected.") unless scholarship_is_valid?
  end


  public
  #Tests that enrollment's scholarship is not nil and that is it between 0 and 2. Returns true or false
  def scholarship_is_valid?
    return false unless self.scholarship != nil
    return ((self.scholarship >= 0) and (self.scholarship <= 2))
  end

  private
  #Adds errors if scholarship_amount_is_valid? returns false
  def scholarship_amount_is_valid
    errors.add(:scholarship_amount, "An invalid scholarship amount was given.") unless scholarship_amount_is_valid?
  end


  public
   #Tests that enrollment's scholarship_amount is not nil, that there exists a course for this enrollment and that the scholarship_amount is between 0 and total fee for course. Returns true or false
  def scholarship_amount_is_valid?
    return false unless self.scholarship_amount != nil
    course = Course.find_by_id(self.course_id)
    return false unless course #make sure course is non-nil
    return ((self.scholarship_amount >= 0) and (self.scholarship_amount <= course.total_fee)) #Make sure the scholarship fee is non-negative and that it is also less than or equal to the total course fee
  end

  private
  #Adds errors if enrollment_is_valid? returns false
  def enrolled_is_valid
    errors.add(:enrolled, "An invalid enrollment value was selected.") unless enrollment_is_valid?
  end


  public
  #Tests that enrolled value was initialized and non-nil. Returns true or false
  def enrollment_is_valid?
    return false unless self.enrolled != nil
    return true
  end

  private
  #Adds errors if course_is_is_valid? returns false
  def course_id_is_valid
    errors.add(:course_id, "No valid class was selected.") unless course_id_is_valid?
  end


  public
   #Tests that course for enrollment's course_id exists and returns true or false.
  def course_id_is_valid?
    return ( Course.find_by_id(self.course_id) != nil )
  end

  private
  #Adds errors if student_not_already_enrolled returns false
  def student_not_already_enrolled
    errors.add(:course_id, "The student is already enrolled in the selected course.") unless student_not_already_enrolled?
  end


  public
  #Tests that student is not already linked to a course in enrollment and returns true or false.
  def student_not_already_enrolled?
    enrollments = Enrollment.where(:student_id => self.student_id, :course_id => self.course_id )
    return true unless enrollments.length > 0
    return true unless self.id != enrollments[0].id
    return false
  end

  private
  #Adds errors if student_id_is_valid? returns false
  def student_id_is_valid
    errors.add(:student_id, "An invalid or non-existant student id was specified.") unless student_id_is_valid?
  end


  public
  #Tests that enrollment's student exists and returns true or false.
  def student_id_is_valid?
    return ( Student.find_by_id(self.student_id) != nil )
  end


  public
  #Returns the corresponding value in the DISMISSAL array based on enrollment's dismissal value
  def dismissal_to_s
    if self.dismissal < DISMISSAL.length;return DISMISSAL[self.dismissal];end
    return "Invalid Value"
  end


  public
  #Return status of if enrolled or not
  def enrolled_to_s
    return "Not Enrolled, Lottery" unless self.enrolled
    return "Enrolled"
  end

end
