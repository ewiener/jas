class ScholarshipReport < Report
	def name
		"Scholarship Report"
	end
	
	def instructors
		@instructors
	end
	
	def enrollments(instructor)
		@enrollments[instructor]
	end
	
	def total_scholarship_amount(instructor)
		unless enrollments(instructor).nil?
			return enrollments(instructor).reduce(0) { |sum, enrollment| sum + enrollment.scholarship_amount}
		end
		return 0
	end
	
	private
	def init_report
		@enrollments = Hash.new { |hash, key| hash[key] = [] }
		@semester.enrollments.enrolled.by_course_day_and_course_name_and_student_name.each do |enrollment|
			if enrollment.has_scholarship?
				@enrollments[enrollment.course.instructor] << enrollment
			end
		end
		@instructors = @enrollments.keys.sort { |a, b| a.full_name_last_first <=> b.full_name_last_first }
	end
end