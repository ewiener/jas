class User < ActiveRecord::Base
  # new columns need to be added here to be writable through mass assignment
  attr_accessible :username,
                  :password,
                  :password_confirmation

  acts_as_authentic do |c|
    c.logged_in_timeout(30.minutes)
  end

end
