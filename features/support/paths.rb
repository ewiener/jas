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
      semester_id = Semester.find_by_name($1).id
      "/semesters/#{semester_id}/courses/new"
    
    when /^the login page$/
      '/logins'
      
    when /^the Session Name Page$/
      '/semesters/new'
    
    when /^the "(.+)" Session Name Page$/
      #semester_id = Semester.where(:name => $1).id
      semester_id = Semester.find_by_name($1).id
      "/semesters/#{semester_id}"
      
    when /^the PTA Instructor home page$/
      "/users"
      
    when /^the Add New PTA Teacher Page$/
      "/users/new"

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
