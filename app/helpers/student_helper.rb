module StudentHelper
	def student_index_heading(filter)
		if filter.empty?
			return "All Students"
		elsif filter[:enrolled] == 'true'
			return "Enrolled Students"
		elsif filter[:enrolled] == 'false'
			return "Unenrolled Students"
		end
	end
end