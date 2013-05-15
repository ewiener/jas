module CourseHelper	
  def full_mode?
  	params[:full] == 'true'
  end
  
	def course_index_heading(filter)
		if filter.empty?
			return "All Classes"
		elsif filter[:enrollment] == 'overenrolled'
			return "Overenrolled Classes"
		elsif filter[:enrollment] == 'underenrolled'
			return "Underenrolled Classes"
		end
	end
end