class User < ActiveRecord::Base
	belongs_to :program
	
  attr_accessible :username,
                  :password,
                  :password_confirmation,
                  :role,
                  :last_semester_id
                  
  ROLES = [
  	{:name => 'App Admin', :id => 0},      # Can create/edit programs and do program/session admin
  	{:name => 'Program Admin', :id => 1},  # Can create/edit users and sessions within own program and do session admin
  	{:name => 'Session Admin', :id => 2}   # Can manage students, classes, etc. for program sessions
  ]

  acts_as_authentic do |c|
    c.logged_in_timeout(30.minutes)
  end

  def role_to_s
  	return ROLES[self.role][:name]
  end
  
  def is_app_admin?
  	return role_to_s == 'App Admin'
  end
  
  def is_program_admin?
  	return is_app_admin? || role_to_s == 'Program Admin'
  end
  
  def is_session_admin?
  	return is_program_admin? || role_to_s == 'Session Admin'
  end
end
