class User < ActiveRecord::Base
	belongs_to :program
	
  attr_accessible :username,
                  :password,
                  :password_confirmation,
                  :role,
                  :last_semester_id
                  
  ROLES = [
  	{:name => 'Super', :id => 0},
  	{:name => 'Admin', :id => 1}
  ]

  acts_as_authentic do |c|
    c.logged_in_timeout(30.minutes)
  end

  def role_to_s
  	return ROLES[self.role][:name]
  end
end
