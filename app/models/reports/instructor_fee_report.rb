class InstructorFeeReport < Report
	attr_reader :instructors, :total_scholarships, :total_instructor_scholarships, :total_fee, :total_invoiced

	InstructorData = Struct.new(:instructor, :courses, :total_scholarships, :total_instructor_scholarships, :total_fee, :total_invoiced)
	CourseData = Struct.new(:course, :num_students, :num_billable_students, :num_scholarships, :num_instructor_scholarships, :total_fee)

	def name
		"Instructor Report"
	end

	private
	def init_report
		@instructors = Array.new
		@total_fee = 0
		@total_invoiced = 0
		@total_scholarships = 0
		@total_instructor_scholarships = 0
		@semester.instructors.by_name.each do |instructor|
			instructor_data = InstructorData.new(instructor, nil, 0, 0, 0, 0)
			instructor_data.courses = Array.new
		  instructor_data.total_invoiced = instructor.total_invoiced_amount
		  instructor.courses.by_day_and_name.each do |course|
		  	num_students = course.num_valid_enrollments
		  	if num_students > 0
		  		num_scholarships = course.num_scholarship_enrollments
		  		num_instructor_scholarships = course.instructor_scholarships.to_i
		  		num_billable_students = num_students - num_instructor_scholarships
		  		course_total_fee = course.total_fee * num_billable_students
		  		course_data = CourseData.new(course, num_students, num_billable_students, num_scholarships, num_instructor_scholarships, course_total_fee)
		  		instructor_data.courses << course_data
		  		instructor_data.total_fee = instructor_data.total_fee + course_total_fee
		  		instructor_data.total_scholarships = instructor_data.total_scholarships + num_scholarships
		  		instructor_data.total_instructor_scholarships = instructor_data.total_instructor_scholarships + num_instructor_scholarships
		  	end
		  end
		  if instructor_data.courses.count > 0
		  	@instructors << instructor_data
		  	@total_fee = @total_fee + instructor_data.total_fee
		  	@total_invoiced = @total_invoiced + instructor_data.total_invoiced
		  	@total_scholarships = @total_scholarships + instructor_data.total_scholarships
		  	@total_instructor_scholarships = @total_instructor_scholarships + instructor_data.total_instructor_scholarships
		  end
		end
	end
end