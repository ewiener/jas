class ScholarshipReport < Report
	attr_reader :instructors, :total_scholarship_amount, :total_scholarships
	
	def name
		"Scholarship Report"
	end
	
	def enrollments(instructor)
		@enrollments[instructor]
	end
	
	def total_scholarship_amount_for(instructor)
		unless enrollments(instructor).nil?
			return enrollments(instructor).reduce(0) { |sum, enrollment| sum + enrollment.scholarship_amount}
		end
		return 0
	end
	
	private
	def init_report
		@enrollments = Hash.new { |hash, key| hash[key] = [] }
		@total_scholarship_amount = 0
		@total_scholarships = 0
		@semester.enrollments.enrolled.by_course_day_and_course_name_and_student_name.each do |enrollment|
			if enrollment.has_scholarship?
				@enrollments[enrollment.course.instructor] << enrollment
				@total_scholarship_amount += enrollment.scholarship_amount
				@total_scholarships = @total_scholarships + 1
			end
		end
		@instructors = @enrollments.keys.sort { |a, b| a.full_name_last_first <=> b.full_name_last_first }
	end
end