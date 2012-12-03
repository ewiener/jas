# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

require 'ostruct'

puts "Seeding..."


User.create(:username => "admin", :password => "asdf", :password_confirmation => "asdf")

semesters = []
semesters.push(OpenStruct.new({
  :name => 'Fall 2012',
  :start_date => '08/22/2012',
  :end_date => '10/24/2012',
  :lottery_deadline => '08/22/2012',
  :registration_deadline => '08/22/2012',
  :fee => 1000,
}))
semesters.push(OpenStruct.new({
  :name => 'Spring 2012',
  :start_date => '01/28/2012',
  :end_date => '03/14/2012',
  :lottery_deadline => '08/22/2012',
  :registration_deadline => '08/22/2012',
  :fee => 2000,
}))
semesters.push(OpenStruct.new({
  :name => 'Winter 2012',
  :start_date => '11/28/2012',
  :end_date => '12/14/2012',
  :lottery_deadline => '08/22/2012',
  :registration_deadline => '08/22/2012',
  :fee => 2000,
}))
semesters.each do |semester|
  # Adding Semesters
  Semester.create(
    name: semester.name,
    start_date: semester.start_date,
    end_date: semester.end_date,
    lottery_deadline: semester.lottery_deadline,
    registration_deadline: semester.registration_deadline,
    fee: 1000.0
  )

  # Adding PTA Instructors
  currentSemester = Semester.find_by_name(semester.name)
  ptainstructors_first_names = ['Benny', 'David', 'Steve']
  ptainstructors_last_names = ['Benassi', 'Guetta', 'Aoki']
  number_of_ptainstructors = 3
  number_of_ptainstructors.times do |t|
    currentSemester.ptainstructors.create(
      first_name: ptainstructors_first_names[t],
      last_name: ptainstructors_last_names[t],
      email: "ptainstructor#{t+1}@gmail.com",
      phone: "1234567890",
      address: "An address somewhere",
    )
  end

  # Adding Teachers
  grades = 'K,1,2,3,4,5'.split(',')
  number_of_teachers = 3
  teacher_names = ['Lil Wayne', 'Kanye West', 'Jermaine Cole']
  number_of_teachers.times do |t|
    randomGrade = grades[rand(grades.length)]
    currentSemester.teachers.create(
      name: teacher_names[t],
      grade: "#{randomGrade}",
      classroom: "A classroom somewhere",
    )
  end

  # Adding Courses
  grades = 'K,1,2,3,4,5'.split(',')
  courses = ['Fun Math', 'Beautiful Photography', 'Rubik\'s Cube']
  ps = []
  ts = []
  Ptainstructor.all.each do |ptainstructa|
    ps.push(ptainstructa.id)
  end
  Teacher.all.each do |teacha|
    ts.push(teacha.id)
  end
  number_of_courses = 3
  number_of_courses.times do |t|

    randomGrade = grades[rand(grades.length)]
    randomMin = rand(50)
    randomMax = rand(50) + 50
    random = rand(100)

    ptainstructorId = ps[rand(ps.length)]
    teacherId = ts[rand(ts.length)]
    ptainstructor = Ptainstructor.find_by_id(ptainstructorId)
    teacher = Teacher.find_by_id(teacherId)

    currentSemester.courses.create(
      name: courses[t],
      description: courses[t],
      sunday: true,
      monday: true,
      tuesday: true,
      wednesday: true,
      thursday: true,
      friday: true,
      saturday: true,
      start_time: "#{t+1}:00pm",
      end_time: "#{t+1}:00pm",
      grade_range: "#{randomGrade}",
      class_min: randomMin,
      class_max: randomMax,
      number_of_classes: randomMin,
      fee_per_meeting: random,
      fee_for_additional_materials: random,
      total_fee: random,
      ptainstructor: ptainstructor,
      teacher: teacher,
    )
  end
end







puts "Seeding Done!"
