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
  validate :semester_id_is_valid
  validate :course_id_is_valid
  validate :student_id_is_valid
  validate :student_not_already_enrolled

  DISMISSAL = ["Pick Up","JAZ","BEARS","Walk"]

  private
  def dismissal_is_valid
    errors.add(:dismissal, 'Invalid dismissal value.') unless dismissal_is_valid?
  end

  public
  def dismissal_is_valid?
    return false unless self.dismissal != nil
    return ((self.dismissal >= 0) and (self.dismissal <= 3))
  end

  private
  def scholarship_is_valid
    errors.add(:scholarship, "Invalid scholarship type was selected.") unless scholarship_is_valid?
  end

  public
  def scholarship_is_valid?
    return false unless self.scholarship != nil
    return ((self.scholarship >= 0) and (self.scholarship <= 2))
  end

  private
  def scholarship_amount_is_valid
    errors.add(:scholarship_amount, "An invalid scholarship amount was given.") unless scholarship_amount_is_valid?
  end

  public
  def scholarship_amount_is_valid?
    return false unless self.scholarship_amount != nil
    course = Course.find_by_id(self.course_id)
    return false unless course #make sure course is non-nil
    return ((self.scholarship_amount >= 0) and (self.scholarship_amount <= course.total_fee)) #Make sure the scholarship fee is non-negative and that it is also less than or equal to the total course fee
  end

  private
  def enrolled_is_valid
    errors.add(:enrolled, "An invalid enrollment value was selected.") unless enrollment_is_valid?
  end

  public
  def enrollment_is_valid?
    #Just check and make sure the value was initialized and non-nil
    return false unless self.enrolled != nil
    return true
  end

  private
  def semester_id_is_valid
    errors.add(:semester_id, "An invalid or non-existant semester id was specified.") unless semester_id_is_valid?
  end

  public
  def semester_id_is_valid?
    return ( Semester.find_by_id(self.semester_id) != nil )
  end

  private
  def course_id_is_valid
    errors.add(:course_id, "No valid class was selected.") unless course_id_is_valid?
  end

  public
  def course_id_is_valid?
    return ( Course.find_by_id(self.course_id) != nil )
  end

  private
  def student_not_already_enrolled
    errors.add(:course_id, "The student is already enrolled in the selected course.") unless student_not_already_enrolled?
  end

  public
  def student_not_already_enrolled?
=begin
    course = Course.find_by_id(self.course_id)
    return false unless course != nil
    student = Student.find_by_id(self.student_id)
    return false unless student != nil
=end
    enrollments = Enrollment.where(:student_id => self.student_id, :course_id => self.course_id )
    return true unless enrollments.length > 0
    return true unless self.id != enrollments[0].id
    return false
  end

  private
  def student_id_is_valid
    errors.add(:student_id, "An invalid or non-existant student id was specified.") unless student_id_is_valid?
  end

  public
  def student_id_is_valid?
    return ( Student.find_by_id(self.student_id) != nil )
  end

  public
  def dismissal_to_s
    if self.dismissal < DISMISSAL.length;return DISMISSAL[self.dismissal];end
    return "Invalid Value"
  end


  public
  def enrolled_to_s
    return "Not Enrolled, Lottery" unless self.enrolled
    return "Enrolled"
  end

end
