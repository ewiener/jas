class Program < ActiveRecord::Base
	has_many :semesters, :dependent => :destroy
	has_many :users, :dependent => :destroy
	
  attr_accessible :short_name, :long_name, :abbrev, :description
  
  validates :short_name, :presence => true
  validates :long_name, :presence => true
  validates :abbrev, :presence => true
  
  scope :by_name, order("short_name asc")
  
  def semesters_by_date
    return semesters.all.sort_by{|semester| semester.start_date_as_date}.reverse
  end
end
