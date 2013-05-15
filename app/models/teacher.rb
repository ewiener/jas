class Teacher < ActiveRecord::Base

  has_many :courses
  has_many :students
  belongs_to :semester
  
  GRADES = ["K","1","2","3","4","5"]

  attr_accessible :name,
                  :grade,
                  :classroom

  validates :grade, :inclusion => { :in => GRADES, :message => 'must be one of ' + GRADES.join(",")}, :allow_blank => true
  validates :classroom, :presence => true
  
  scope :with_teacher, where("name <> ''")
  scope :alphabetical_by_teacher, order("name asc")
  scope :alphabetical_by_room, order("classroom asc")
  scope :alphabetical_by_grade, order("case when grade = 'K' then '0' else grade end asc, name asc")
  default_scope alphabetical_by_room

  #Tests that teacher is not linked to any course or student so it can be deleted
  def can_be_deleted?
    return !active?
  end
  
  def active?
  	return courses.any? || students.any?
  end
  
  def allowable_grades
  	GRADES
  end
  
  def has_teacher?
  	self.name && !self.name.empty?
  end

  def classroom_with_teacher_name
  	str = self.classroom
  	if has_teacher?
  		str << " (" << self.name << ")"
  	end
  	return str
  end
end
