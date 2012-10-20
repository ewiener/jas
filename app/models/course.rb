# PTA Course held within a specific Semester.
# PTA Course held within a specific Semester.
# PTA Course held within a specific Semester.
# PTA Course held within a specific Semester.
# PTA Course held within a specific Semester:
# * asdfasdf
# * asdfasdfasdf
# * asdfasdfa
class Course < ActiveRecord::Base
  belongs_to :session
  has_many :ptainstructors
  has_many :students

end
