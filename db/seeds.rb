# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

puts "Seeding..."

# Create Programs
master = Program.create(
  :short_name => 'Master',
  :long_name => 'Master',
  :abbrev => 'Master',
  :description => 'Empty placeholder program for attaching the super user'
)
jas = Program.create(
	:short_name => 'Jefferson PTA',
	:long_name => 'Jefferson PTA After School Classes',
	:abbrev => 'JAS'
)

# Create Users
master.users.create(
	:username => "super",
	:password => "super",
	:password_confirmation => "changeme",
	:role => 0
)
jas.users.create(
  :username => "jasadmin", 
  :password => "changeme", 
  :password_confirmation => "changeme",
  :role => 1
)

semesters = []
semesters.push({
  :name => 'Fall 2012',
  :start_date => '09/22/2012',
  :end_date => '12/15/2012',
  :lottery_deadline => '09/15/2012',
  :registration_deadline => '09/08/2012',
  :fee => 10,
})
semesters.push({
  :name => 'Spring 2013',
  :start_date => '02/04/2013',
  :end_date => '05/03/2013',
  :lottery_deadline => '01/18/2013',
  :registration_deadline => '01/25/2013',
  :fee => 20,
})
semesters.each do |semester|
  # Create Semester
  current_semester = jas.semesters.create(semester)

  # Add Instructors
  instructors_first_names = ['Kalen', 'Lolly', 'Henri']
  instructors_last_names = ['Meyer', 'Watanabe', 'Ducharme']
  number_of_instructors = 3
  number_of_instructors.times do |t|
    current_semester.instructors.create(
      first_name: instructors_first_names[t],
      last_name: instructors_last_names[t],
      email: "instructor#{t+1}@gmail.com",
      phone: "123-456-7890",
      address: "An address somewhere",
    )
  end

  # Add Classrooms
  classrooms = []
  classrooms.push({
  	:name => '101',
  	:teacher => 'Anna Wong',
  	:grade => 'K' 
  })
  classrooms.push({
  	:name => '103',
  	:teacher => 'Barry Fike',
  	:grade => '3'
  })
  classrooms.push({
  	:name => '201',
  	:teacher => 'Barb Wenger',
  	:grade => '4'
  }) 
  current_semester.classrooms.create(classrooms)

  is = current_semester.instructors.map { |p| p.id }
  cs = current_semester.classrooms.map { |t| t.id }

  # Add Students 
  grades = ['K', '1', '2', '3', '4', '5']
  students_first_names = ['Italo', 'John', 'Jorge']
  students_last_names = ['Calvino', 'Barth', 'Borges']
  number_of_students = 3
  number_of_students.times do |t|
    randomGrade = grades[rand(grades.length)]
    classroom = Classroom.find_by_id(cs[rand(cs.length)])

    current_semester.students.create(
      first_name: students_first_names[t],
      last_name: students_last_names[t],
      grade: "#{randomGrade}",
      parent_phone: "123-456-7890",
      parent_name: "Mr. Parent",
      parent_email: "parent#{t+1}@gmail.com",
      classroom: classroom,
    )
  end

  # Add Courses
  grades = 'K,1,2,3,4,5'.split(',')
  courses = ['Constructing Art', 'Fun with Mandarin', 'Skilly Circus']
  number_of_courses = 3
  number_of_courses.times do |t|
    randomGrade = grades[rand(grades.length)]
    
    instructor = Instructor.find_by_id(is[rand(is.length)])
    classroom = Classroom.find_by_id(cs[rand(cs.length)])

    current_semester.courses.create(
      name: courses[t],
      description: courses[t],
      sunday: false,
      monday: true,
      tuesday: false,
      wednesday: false,
      thursday: false,
      friday: false,
      saturday: false,
      start_time: "#{t+1}:00pm",
      end_time: "#{t+1}:00pm",
      grade_range: "#{randomGrade}",
      class_min: rand(10),
      class_max: rand(10) + 10,
      fee_per_meeting: rand(10),
      fee_for_additional_materials: rand(10),
      course_fee: rand(20) + 50,
      instructor: instructor,
      classroom: classroom,
    )
  end
end

puts "Seeding Done!"
