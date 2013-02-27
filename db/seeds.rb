# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

require 'ostruct'

puts "Seeding..."

User.create(:username => "admin", :password => "jrocks", :password_confirmation => "jrocks")

semesters = []
semesters.push(OpenStruct.new({
  :name => 'Fall 2012',
  :start_date => '09/22/2012',
  :end_date => '12/15/2012',
  :lottery_deadline => '09/15/2012',
  :registration_deadline => '09/08/2012',
  :fee => 1000,
}))
semesters.push(OpenStruct.new({
  :name => 'Spring 2013',
  :start_date => '02/04/2013',
  :end_date => '05/03/2013',
  :lottery_deadline => '01/18/2013',
  :registration_deadline => '01/25/2013',
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

  currentSemester = Semester.find_by_name(semester.name)

  # Adding PTA Instructors
  ptainstructors_first_names = ['Kalen', 'Lolly', 'Henri']
  ptainstructors_last_names = ['Meyer', 'Watanabe', 'Ducharme']
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
  teacher_names = ['Anna Wong', 'Barry Fike', 'Barb Wenger']
  number_of_teachers.times do |t|
    randomGrade = grades[rand(grades.length)]
    teacher = currentSemester.teachers.create(
      name: teacher_names[t],
      grade: "#{randomGrade}",
      classroom: "A classroom somewhere",
    )
  end

  ps = []
  ts = []
  Ptainstructor.all.each do |ptainstructa|
    ps.push(ptainstructa.id)
  end
  Teacher.all.each do |teacha|
    ts.push(teacha.id)
  end

  # Adding Students 
  students_first_names = ['Italo', 'John', 'Jorge']
  students_last_names = ['Calvino', 'Barth', 'Borges']
  number_of_students = 3
  number_of_students.times do |t|

    randomGrade = grades[rand(grades.length)]
    teacherId = ts[rand(ts.length)]
    teacher = Teacher.find_by_id(teacherId)

    currentSemester.students.create(
      first_name: students_first_names[t],
      last_name: students_last_names[t],
      grade: "#{randomGrade}",
      parent_phone: "1234567890",
      parent_name: "Mr. Parent",
      parent_email: "parent#{t+1}@gmail.com",
      teacher: teacher,
    )
  end

  # Adding Courses
  grades = 'K,1,2,3,4,5'.split(',')
  courses = ['Constructing Art', 'Fun with Mandarin', 'Skilly Circus']
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
