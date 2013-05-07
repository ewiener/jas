module CourseHelper
	def course_name_with_grade_level(course)
		course_name = course.name
		if course.grade_range && !course.grade_range.empty?
			course_name << " (" << course.grade_range << ")"
		end
		return course_name
	end
	
	def course_name_with_day_and_grade_level(course)
		days = course.abbrev_days.map {|day| day.upcase}.join(",")
		course_name = "#{days}: #{course_name_with_grade_level(course)}"
	end
	
  def full_mode?
  	params[:full] == 'true'
  end
end