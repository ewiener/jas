class Classroom < ActiveRecord::Base

  has_many :courses
  has_many :students
  belongs_to :semester

  GRADES = ["TK", "K","1","2","3","4","5"]

  attr_accessible :name,
                  :grade,
                  :teacher

  validates :name, :presence => true
  validates :grade, :inclusion => { :in => GRADES, :message => 'must be one of ' + GRADES.join(",")}, :allow_blank => true

  scope :with_teacher, where("teacher <> ''")
  scope :by_name, order("name asc")
  scope :by_teacher, order("teacher asc")
  scope :by_grade_and_name, order("case when grade = 'TK' then '-1' when grade = 'K' then '0' else grade end asc, name asc")
  scope :by_grade_and_teacher, order("case when grade = 'TK' then '-1' when grade = 'K' then '0' else grade end asc, teacher asc")

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
  	str = String.new(self.name)
    str << " (" << self.teacher << ")" if has_teacher?
    return str
  end

  def teacher_with_grade
  	str = ""
  	str << self.teacher if self.teacher
  	str << " (" << self.grade << ")" if self.grade
  	return str
  end
end
