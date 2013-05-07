class Teacher < ActiveRecord::Base

  has_many :courses
  belongs_to :semester
  
  GRADES = ["K","1","2","3","4","5"]

  attr_accessible :name,
                  :grade,
                  :classroom,
                  :semester

  validates :grade, :inclusion => { :in => GRADES, :message => 'must be one of ' + GRADES.join(",")}, :allow_blank => true
  validates :classroom, :presence => true
  
  scope :alphabetical_by_teacher, order("name asc")
  scope :alphabetical_by_room, order("classroom asc")
  scope :alphabetical_by_grade, order("case when grade = 'K' then '0' else grade end asc, name asc")
  default_scope alphabetical_by_room

  #Tests that teacher is not linked to any course or student so it can be deleted
  def can_be_deleted?
    courses = Course.where(:semester_id => self.semester, :teacher_id => self.id)
    students = Student.where(:semester_id => self.semester, :teacher_id => self.id)

    return ((courses.length + students.length) == 0)
  end
  
  def allowable_grades
  	GRADES
  end

end
