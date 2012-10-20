class Course < ActiveRecord::Base
  belongs_to :session
  has_many :ptainstructors
  has_many :students

end
