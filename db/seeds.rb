# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

semesters = ['Fall 2012', 'Spring 2012', 'Winter 2012']
semesters.each do |my_semester|
  Semester.create(
    name: my_semester,
    start_date: "08/22/2012",
    end_date: "12/24/2012",
    lottery_deadline: "08/22/2012",
    registration_deadline: "08/22/2012",
    fee: 1000.0
  )
  semester = Semester.find_by_name(my_semester)
  number_of_ptainstructors = 3
  semester.ptainstructors.create(
    name: "#{my_semester} PTA Instructor #{ptainstructor_count}",
    email: "ptainstructor1@gmail.com",
    phone: "1234567890",
    address: "Somewhere",
  )
end







