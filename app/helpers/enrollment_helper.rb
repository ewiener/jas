module EnrollmentHelper
	def enrollment_index_heading(filter)
		if filter.empty?
			return "Full Roster"
		elsif filter[:teacher]
			return "Roster for Teacher: " + filter[:teacher].teacher
		elsif filter[:dismissal]
			return filter[:dismissal][:name] + " Students"
		end
	end
end