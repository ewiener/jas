class Ptainstructor < ActiveRecord::Base

  has_many :courses
  has_many :teachers, :through => :courses
  belongs_to :semester
  has_many :students, :through => :courses

  attr_accessible :first_name,
                  :last_name,
                  :email,
                  :phone,
                  :address,
                  :bio

  validates :last_name, :presence => true
  validates_format_of :email, :with => /@/, :allow_blank => true
  validates_format_of :phone, :with => /^\(?([0-9]{3})\)?[-. ]?([0-9]{3})[-. ]?([0-9]{4})$/, :allow_blank => true

  scope :alphabetical, order("last_name asc, first_name asc")
  default_scope alphabetical

  #Tests that ptainstructor is not linked to any courses in the semester and returns true or false.
  def can_be_deleted?
  	!has_courses?
  end
  
  def has_courses?
  	courses.count > 0
  end

  #Returns last_name, first_name or just first_name if no last_name exists
  def full_name_last_first
    return self.first_name unless (self.last_name.length > 0)
    return (self.last_name + ", " + self.first_name)
  end

  #Returns first_name, last_name or just first_name if no last_name exists
  def full_name_first_last
    return self.first_name unless (self.last_name.length > 0)
    return (self.first_name + " " + self.last_name)
  end

  #Formats number properly
  def formatted_number(number)
    digits = number.gsub(/\D/, '').split(//)

    if (digits.length == 10)
      digits = digits.join
      '(%s) %s-%s' % [ digits[0,3], digits[3,3], digits[6,4] ]
    end
  end
end
