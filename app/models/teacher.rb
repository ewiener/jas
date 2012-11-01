class Teacher < ActiveRecord::Base

  has_many :courses

  attr_accessible :name,
                  :grade,
                  :classroom
                  
  
  validate :name_is_valid
  validate :grade_is_valid
  validate :classroom_is_valid
  
  private
  # Used by validation check to verify that the name is valid
  def name_is_valid
    errors.add(:name,"Invalid empty string for name.") unless name_is_valid?
  end
  
  # Used by validation check to verify that the grade is valid
  def name_is_valid
    errors.add(:grade,"Invalid empty string for grade.") unless grade_is_valid?
  end
  
  # Used by validation check to verify that the classroom is valid
  def classroom_is_valid
    errors.add(:classroom,"Invalid empty string for classroom.") unless classroom_is_valid?
  end

  public
  # Verifies that the name is valid
  def name_is_valid?
    return self.name.length > 0
  end
  
  # Verifies that the grade is valid
  def grade_is_valid?
    return self.grade.length > 0
  end
  
  # Verifies that the classroom is valid
  def classroom_is_valid?
    return self.classroom.length > 0
  end

end
