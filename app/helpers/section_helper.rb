module SectionHelper	 
	SITE_SECTIONS = {
	 	:programs_section => {
	 		:name => 'Programs',
	 		:path => lambda {|context| Rails.application.routes.url_helpers.programs_path}
	 	},	 	
		:program_home_section => {
			:name => 'Home',
			:path => lambda {|context| Rails.application.routes.url_helpers.home_of_program_path(context[:program])}
		},
	 	:users_section => {
	 		:name => 'Users',
	 		:path => lambda {|context| Rails.application.routes.url_helpers.program_users_path(context[:program])}
	 	},	 	
	 	:semesters_section => {
	 		:name => 'Sessions',
	 		:path => lambda {|context| Rails.application.routes.url_helpers.program_semesters_path(context[:program])}
	 	},
		:semester_home_section => {
			:name => 'Home',
			:path => lambda {|context| Rails.application.routes.url_helpers.home_of_semester_path(context[:semester])}
		},
	 	:students_section => {
	 		:name => 'Students',
	 		:path => lambda {|context| Rails.application.routes.url_helpers.semester_students_path(context[:semester])}
	 	},
	 	:instructors_section => {
	 		:name => 'Instructors',
	 		:path => lambda {|context| Rails.application.routes.url_helpers.semester_instructors_path(context[:semester])}
	 	},
	 	:classrooms_section => {
	 		:name => 'Rooms',
	 		:path => lambda {|context| Rails.application.routes.url_helpers.semester_classrooms_path(context[:semester])}
	 	},
	 	:courses_section => {
	 		:name => 'Classes',
	 		:path => lambda {|context| Rails.application.routes.url_helpers.semester_courses_path(context[:semester])}
	 	},
	 	:enrollments_section => {
	 		:name => 'Rolls',
	 		:path => lambda {|context| Rails.application.routes.url_helpers.semester_enrollments_path(context[:semester])}
	 	},
	 	:reports_section => {
	 		:name => 'Reports',
	 		:path => lambda {|context| Rails.application.routes.url_helpers.semester_reports_path(context[:semester])}
	 	}
	}
	 
  def site_sections
  	SITE_SECTIONS
  end
  
  def link_to_section(section, context, options = {}, &block)
  	if block.present?
  		link_to section_path(section, context), options, &block
    else
    	link_to section_name(section), section_path(section, context), options
    end
  end
  
  def section_name(section)
  	site_sections[section][:name]
  end
  
  def section_path(section, context)
    site_sections[section][:path].call(context)
  end
end
