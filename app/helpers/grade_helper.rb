module GradeHelper
	def grade_options_for_select(grades, selected)
		options = grades.map{ |grade| [grade, grade]}
		return options_for_select(options, selected)
	end
end