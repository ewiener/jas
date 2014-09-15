class InstructorFeeReport < Report
	attr_reader :instructors, :total_fee

	InstructorData = Struct.new(:instructor, :courses, :total_fee)
	CourseData = Struct.new(:course, :num_students, :num_scholarships, :total_fee)

	def name
		"Instructor Fee Report"
	end

	private
	def init_report
		@instructors = Array.new
		@total_fee = 0
		@semester.instructors.by_name.each do |instructor|
			instructor_data = InstructorData.new(instructor, nil, 0)
			instructor_data.courses = Array.new
		  instructor.courses.by_day_and_name.each do |course|
		  	num_students = course.num_valid_enrollments
		  	if num_students > 0
		  		num_scholarships = course.num_scholarship_enrollments
		  		course_total_fee = course.total_fee * num_students
		  		course_data = CourseData.new(course, num_students, num_scholarships, course_total_fee)
		  		instructor_data.courses << course_data
		  		instructor_data.total_fee = instructor_data.total_fee + course_total_fee
		  	end
		  end
		  if instructor_data.courses.count > 0
		  	@instructors << instructor_data
		  	@total_fee = @total_fee + instructor_data.total_fee
		  end
		end
	end
end