module SectionHelper	 
	SITE_SECTIONS = {
	 	:semesters_section => {
	 		:name => 'Sessions',
	 		:path => lambda {|semester| Rails.application.routes.url_helpers.semesters_path}
	 	},
		:semester_home_section => {
			:name => 'Home',
			:path => lambda {|semester| Rails.application.routes.url_helpers.home_of_semester_path(semester)}
		},
	 	:students_section => {
	 		:name => 'Students',
	 		:path => lambda {|semester| Rails.application.routes.url_helpers.semester_students_path(semester)}
	 	},
	 	:instructors_section => {
	 		:name => 'Instructors',
	 		:path => lambda {|semester| Rails.application.routes.url_helpers.semester_instructors_path(semester)}
	 	},
	 	:classrooms_section => {
	 		:name => 'Classrooms',
	 		:path => lambda {|semester| Rails.application.routes.url_helpers.semester_classrooms_path(semester)}
	 	},
	 	:courses_section => {
	 		:name => 'Classes',
	 		:path => lambda {|semester| Rails.application.routes.url_helpers.semester_courses_path(semester)}
	 	},
	 	:enrollments_section => {
	 		:name => 'Enrollments',
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
  
  def link_to_section(section, semester, options = {}, &block)
  	if block.present?
  		link_to section_path(section, semester), options, &block
    else
    	link_to section_name(section), section_path(section, semester), options
    end
  end
  
  def section_name(section)
  	site_sections[section][:name]
  end
  
  def section_path(section, semester)
    site_sections[section][:path].call(semester)
  end
end
