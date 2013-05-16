class User < ActiveRecord::Base
	belongs_to :program
	
  attr_accessible :username,
                  :password,
                  :password_confirmation,
                  :role

  acts_as_authentic do |c|
    c.logged_in_timeout(30.minutes)
  end

end
