class User < ActiveRecord::Base
  attr_accessible :username,
                  :password,
                  :password_confirmation

  acts_as_authentic do |c|
    c.logged_in_timeout(30.minutes)
  end

end
