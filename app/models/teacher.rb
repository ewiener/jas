class Teacher < ActiveRecord::Base

  has_many :courses

  GRADES = ["K","k","1","2","3","4","5"]

  attr_accessible :name,
                  :grade,
                  :classroom,
                  :semester

  belongs_to :semester

  validate :name_is_valid
  validate :grade_is_valid
  validate :classroom_is_valid

  private
  # Used by validation check to verify that the name is valid
  def name_is_valid
    errors.add(:name,"Invalid empty string for name.") unless name_is_valid?
  end

  # Used by validation check to verify that the grade is valid
  def grade_is_valid
    errors.add(:grade,"Invalid grade entered. Only K, 1, 2, 3, 4, and 5 are allowed.") unless grade_is_valid?
  end

  # Used by validation check to verify that the classroom is valid
  def classroom_is_valid
    errors.add(:classroom,"Invalid empty string for classroom.") unless classroom_is_valid?
  end

  # Used by validation to check if the type is not nil and that it is of type String
  def not_nil_and_string(str)
    return true unless str == nil or not str.instance_of? String
    return false
  end

  public
  # Verifies that the name is valid by checking name is not nil, string, and at least 1 character
  def name_is_valid?
    return false unless not_nil_and_string(self.name)
    return self.name.length > 0
  end

  # Verifies that the grade is valid by checking if grade is part of K-5
  def grade_is_valid?
    if not_nil_and_string(self.grade)
      if GRADES.include? self.grade
        if self.grade == "k";self.grade = "K";end #force uppercase K
        return true
      end
    end
    return false
  end

  # Verifies that the classroom is valid by checking that is not nil, string, and is at least 1 character
  def classroom_is_valid?
    return false unless not_nil_and_string(self.classroom)
    return self.classroom.length > 0
  end

  #Tests that teacher is not linked to any course or student so it can be deleted
  def can_be_deleted?
    courses = Course.where(:semester_id => self.semester, :teacher_id => self.id)
    students = Student.where(:semester_id => self.semester, :teacher_id => self.id)

    return ((courses.length + students.length) == 0)
  end

end
