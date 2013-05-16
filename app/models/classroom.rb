class Classroom < ActiveRecord::Base

  has_many :courses
  has_many :students
  belongs_to :semester
  
  GRADES = ["K","1","2","3","4","5"]

  attr_accessible :name,
                  :grade,
                  :teacher

  validates :name, :presence => true
  validates :grade, :inclusion => { :in => GRADES, :message => 'must be one of ' + GRADES.join(",")}, :allow_blank => true
  
  scope :with_teacher, where("teacher <> ''")
  scope :alphabetical_by_name, order("name asc")
  scope :alphabetical_by_teacher, order("teacher asc")
  scope :alphabetical_by_grade, order("case when grade = 'K' then '0' else grade end asc, name asc")
  default_scope alphabetical_by_name

  #Tests that classroom is not linked to any course or student so it can be deleted
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
  	self.teacher && !self.teacher.empty?
  end

  def name_with_teacher_name
  	str = self.name
  	if has_teacher?
  		str << " (" << self.teacher << ")"
  	end
  	return str
  end
end
