module NavigationHelpers
  # Maps a name to a path. Used by the
  #
  #   When /^I go to (.+)$/ do |page_name|
  #
  # step definition in web_steps.rb
  #
  def path_to(page_name)
    case page_name

    when /^the home\s?page$/
      '/semesters'
      
    when /^the "(.+)" Create Class Page$/
      begin
        semester_id = Semester.find_by_name($1).id
        "/semesters/#{semester_id}/courses/new"
      rescue
        semester_id = Semester.all.length + 1
        "/semesters/#{semester_id}/courses/new"
      end
    
    when /^the login page$/
      '/'
      
    when /^the Session Name Page$/
      '/semesters/new'
      
    when /^the "(.+)" Classroom Classrooms home page$/
      begin
        semester_id = Semester.find_by_name($1).id
        "/semesters/#{semester_id}/classrooms"
      rescue
        semester_id = Semester.all.length + 1
        "/semesters/#{semester_id}/classrooms"
      end
      
    when /^the "(.+)" Add New Classroom Page$/
      begin
        semester_id = Semester.find_by_name($1).id
        "/semesters/#{semester_id}/classrooms/new"
      rescue
        semester_id = Semester.all.length + 1
        "/semesters/#{semester_id}/classrooms/new"
      end
    
    when /^the "(.+)" Session Name Page$/
      begin
        semester_id = Semester.find_by_name($1).id
        "/semesters/#{semester_id}"
      rescue
        semester_id = Semester.all.length + 1
        "/semesters/#{semester_id}"
      end
      
    when /^the "(.+)" new Course Name Page$/
      begin
        semester_id = Semester.find_by_name($1).id
        "/semesters/#{semester_id}/courses/new"
      rescue
        semester_id = Semester.all.length + 1
        "/semesters/#{semester_id}/courses/new"
      end
      
    when /^the "(.+)" Course Page$/
      begin
        semester_id = Semester.find_by_name($1).id
        "/semesters/#{semester_id}/courses"
      rescue
        semester_id = Semester.all.length + 1
        "/semesters/#{semester_id}/courses"
      end
      
    when /^the "(.+)" "(.+)" Course Edit Page$/
      begin
        semester_id = Semester.find_by_name($1).id
        course_id = Course.find_by_name($2).id
        "/semesters/#{semester_id}/courses/#{course_id}/edit"
      rescue
          begin
            semester_id = Semester.find_by_name($1).id
            course_id = Course.all.length + 1
            "/semesters/#{semester_id}/courses/#{course_id}/edit"
          rescue
            semester_id = Semester.all.length + 1
            course_id = Course.all.length + 1
            "/semesters/#{semester_id}/courses/#{course_id}/edit"
          end
      end
      
    when /^the "(.+)" "(.+)" Classroom Classrooms edit page$/
      begin
        semester_id = Semester.find_by_name($1).id
        classroom_id = Classroom.find_by_name($2).id
        "/semesters/#{semester_id}/classrooms/#{classroom_id}/edit"
      rescue
          begin
            semester_id = Semester.find_by_name($1).id
            classroom_id = Classroom.all.length + 1
            "/semesters/#{semester_id}/classrooms/#{classroom_id}/edit"
          rescue
            semester_id = Semester.all.length + 1
            classroom_id = Classroom.all.length + 1
            "/semesters/#{semester_id}/classrooms/#{classroom_id}/edit"
          end
      end
      
    when /^the "(.+)" Course home page$/
      begin
        semester_id = Semester.find_by_name($1).id
      rescue
        semester_id = Semester.all.length + 1
      end
      "/semesters/#{semester_id}/courses"
      
    when /^the "(.+)" PTA Instructor home page$/
      begin
        semester_id = Semester.find_by_name($1).id
      rescue
        semester_id = Semester.all.length + 1
      end
      "/semesters/#{semester_id}/instructors"
      
    when /^the "(.+)" Add New PTA Classroom Page$/
      semester_id = Semester.find_by_name($1).id
      "/semesters/#{semester_id}/instructors/new"
    
    when /^the "(.+)" "(.+)" PTA Instructor Edit Page$/
      begin
        semester_id = Semester.find_by_name($1).id
        pta_id = Instructor.find_by_name($2).id
        "/semesters/#{semester_id}/instructors/#{classroom_id}/edit"
      rescue
          begin
            semester_id = Semester.find_by_name($1).id
            classroom_id = Instructor.all.length + 1
            "/semesters/#{semester_id}/instructors/#{classroom_id}/edit"
          rescue
            semester_id = Semester.all.length + 1
            classroom_id = Instructor.all.length + 1
            "/semesters/#{semester_id}/instructors/#{classroom_id}/edit"
          end
      end
      
    when /^the "(.+)" Students home page$/
      begin
        semester_id = Semester.find_by_name($1).id
      rescue
        semester_id = Semester.all.length + 1
      end
      "/semesters/#{semester_id}/students"
      
    when /^the "(.+)" New Students Page$/
      begin
        semester_id = Semester.find_by_name($1).id
      rescue
        semester_id = Semester.all.length + 1
      end
      "/semesters/#{semester_id}/students/new"
      
    when /^the "(.+)" "(.+)" Edit Students Page$/
      begin
        semester_id = Semester.find_by_name($1).id
      rescue
        semester_id = Semester.all.length + 1
      end
      begin
        student_id = Student.find_by_first_name($2).id
      rescue
        student_id = Student.all.length + 1
      end
      "/semesters/#{semester_id}/students/#{student_id}/edit"

    else
      begin
        page_name =~ /^the (.*) page$/
        path_components = $1.split(/\s+/)
        self.send(path_components.push('path').join('_').to_sym)
      rescue NoMethodError, ArgumentError
        raise "Can't find mapping from \"#{page_name}\" to a path.\n" +
          "Now, go and add a mapping in #{__FILE__}"
      end
    end
  end
end

World(NavigationHelpers)
