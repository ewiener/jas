class Program < ActiveRecord::Base
	has_many :semesters, 
	  :dependent => :destroy, 
	  :after_add => :semesters_updated, 
	  :after_remove => :semesters_updated do
	  	def all_by_date
	  		@semesters_by_date ||= all.sort_by{|semester| semester.start_date_as_date}.reverse
	  	end
	  end
	has_many :users, :dependent => :destroy
	
  attr_accessible :short_name, :long_name, :abbrev, :description
  
  validates :short_name, :presence => true
  validates :long_name, :presence => true
  validates :abbrev, :presence => true
  
  scope :by_name, order("short_name asc")
  
  def semesters_updated
  	@semesters_by_date = nil
  end
  
  def latest_semester
  	return semesters.all_by_date.length > 0 ? semesters.all_by_date[0] : nil
  end
end
