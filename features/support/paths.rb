# TL;DR: YOU SHOULD DELETE THIS FILE
#
# This file is used by web_steps.rb, which you should also delete
#
# You have been warned
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
      '/logins'
      
    when /^the Session Name Page$/
      '/semesters/new'
      
    when /^the "(.+)" Classroom Teachers home page$/
      begin
        semester_id = Semester.find_by_name($1).id
        "/semesters/#{semester_id}/teachers"
      rescue
        semester_id = Semester.all.length + 1
        "/semesters/#{semester_id}/teachers"
      end
      
    when /^the "(.+)" Add New Classroom Page$/
      begin
        semester_id = Semester.find_by_name($1).id
        "/semesters/#{semester_id}/teachers/new"
      rescue
        semester_id = Semester.all.length + 1
        "/semesters/#{semester_id}/teachers/new"
      end
    
    when /^the "(.+)" Session Name Page$/
      #semester_id = Semester.where(:name => $1).id
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
      
    when /^the "(.+)" "(.+)" Classroom Teachers edit page$/
      begin
        semester_id = Semester.find_by_name($1).id
        classroom_id = Teacher.find_by_name($2).id
        "/semesters/#{semester_id}/teachers/#{classroom_id}/edit"
      rescue
          begin
            semester_id = Semester.find_by_name($1).id
            classroom_id = Teacher.all.length + 1
            "/semesters/#{semester_id}/teachers/#{classroom_id}/edit"
          rescue
            semester_id = Semester.all.length + 1
            classroom_id = Teacher.all.length + 1
            "/semesters/#{semester_id}/teachers/#{classroom_id}/edit"
          end
      end
      
    when /^the "(.+)" PTA Instructor home page$/
      begin
        semester_id = Semester.find_by_name($1).id
      rescue
        semester_id = Semester.all.length + 1
      end
      "/semesters/#{semester_id}/ptainstructors"
      
    when /^the "(.+)" Add New PTA Teacher Page$/
      semester_id = Semester.find_by_name($1).id
      "/semesters/#{semester_id}/ptainstructors/new"
    
    when /^the "(.+)" "(.+)" PTA Instructor Edit Page$/
      begin
        semester_id = Semester.find_by_name($1).id
        pta_id = Ptainstructor.find_by_name($2).id
        "/semesters/#{semester_id}/ptainstructors/#{classroom_id}/edit"
      rescue
          begin
            semester_id = Semester.find_by_name($1).id
            classroom_id = Ptainstructor.all.length + 1
            "/semesters/#{semester_id}/ptainstructors/#{classroom_id}/edit"
          rescue
            semester_id = Semester.all.length + 1
            classroom_id = Ptainstructor.all.length + 1
            "/semesters/#{semester_id}/ptainstructors/#{classroom_id}/edit"
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
      
    # Add more mappings here.
    # Here is an example that pulls values out of the Regexp:
    #
    #   when /^(.*)'s profile page$/i
    #     user_profile_path(User.find_by_login($1))

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
