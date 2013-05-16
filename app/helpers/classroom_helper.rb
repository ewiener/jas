module ClassroomHelper
	def classroom_index_heading(filter)
		if filter.empty?
			return "All Teachers/Rooms"
		elsif filter[:active] == 'true'
			return "Active Teachers/Rooms"
		elsif filter[:active] == 'false'
			return "Inactive Teachers/Rooms"
		end
	end
end