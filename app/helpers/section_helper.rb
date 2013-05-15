module SectionHelper	 
	SITE_SECTIONS = {
	 	:semesters_section => {
	 		:name => 'Sessions',
	 		:path => lambda {|semester| Rails.application.routes.url_helpers.semesters_path}
	 	},
	 	:students_section => {
	 		:name => 'Students',
	 		:path => lambda {|semester| Rails.application.routes.url_helpers.semester_students_path(semester)}
	 	},
	 	:instructors_section => {
	 		:name => 'Instructors',
	 		:path => lambda {|semester| Rails.application.routes.url_helpers.semester_ptainstructors_path(semester)}
	 	},
	 	:teachers_section => {
	 		:name => 'Rooms',
	 		:path => lambda {|semester| Rails.application.routes.url_helpers.semester_teachers_path(semester)}
	 	},
	 	:courses_section => {
	 		:name => 'Classes',
	 		:path => lambda {|semester| Rails.application.routes.url_helpers.semester_courses_path(semester)}
	 	},
	 	:enrollments_section => {
	 		:name => 'Rolls',
	 		:path => lambda {|semester| Rails.application.routes.url_helpers.semester_enrollments_path(semester)}
	 	},
	 	:users_section => {
	 		:name => 'Users',
	 		:path => lambda {|semester| ''}
	 	},
	}
	 
  def site_sections
  	SITE_SECTIONS
  end
  
  def link_to_section(section, semester, *options)
  	 link_to site_sections[section][:name], site_sections[section][:path].call(semester), *options
  end
  
  def section_path(section, semester)
    site_sections[section][:path].call(semester)
  end
end
