module InstructorHelper
	def instructor_index_heading(filter)
		if filter.empty?
			return "All Instructors"
		elsif filter[:active] == 'true'
			return "Active Instructors"
		elsif filter[:active] == 'false'
			return "Inactive Instructors"
		end
	end
end