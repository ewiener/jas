class Report
	attr_accessor :id, :name, :semester
	  
  # 3,2 -> 302
  def self.make_id(semester_id, local_report_id)
  	semester_id * 100 + local_report_id
  end
  
  # 302 -> 3
  def self.parse_semester_id(id)
  	return (id / 100).to_i
  end
  
  def self.find(id)
  	id = id.to_i
  	semester_id = self.parse_semester_id(id)
  	semester = Semester.find(semester_id)
  	semester ? semester.find_report(id) : nil
  end
	
	def initialize(semester, local_report_id)
		@semester, @id = semester, Report.make_id(semester.id, local_report_id)
		init_report
	end
end