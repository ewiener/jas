# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

require 'ostruct'

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
semesters.each do |isemester|
  # Adding Semesters
  Semester.create(
    name: isemester.name,
    start_date: isemester.start_date,
		end_date: isemester.end_date,
    lottery_deadline: isemester.lottery_deadline,
    registration_deadline: isemester.registration_deadline,
    fee: isemester.fee
  )

  # Adding PTA Instructors
  semester = Semester.find_by_name(isemester.name)
  number_of_ptainstructors = 3
  number_of_ptainstructors.times do |t|
    semester.ptainstructors.create(
      name: "#{isemester.name} PTA Instructor #{t+1}",
      email: "ptainstructor#{t+1}@gmail.com",
      phone: "1234567890",
      address: "An address somewhere",
    )
  end

  # Adding Teachers
  grades = 'K,1,2,3,4,5'.split(',')

  number_of_teachers = 3
	teacher_names = ['Takashi Murakami', 'Kanye West', 'Jermaine Cole']

  number_of_teachers.times do |t|
  	randomGrade = grades[rand(grades.length)]
    semester.teachers.create(
      name: teacher_names[t],
      grade: "#{randomGrade}",
      classroom: "A classroom somewhere",
    )
  end

#  # Adding Courses
#  grades = 'K,1,2,3,4,5'.split(',')
#  ps = []
#  ts = []
#  Ptainstructor.all.each do |ptainstructa|
#    ps.push(ptainstructa.id)
#  end
#  Teacher.all.each do |teacha|
#    ts.push(teacha.id)
#  end
#  number_of_courses = 3
#  number_of_courses.times do |t|
#    randomGrade = grades[rand(grades.length)]
#    randomMin = rand(50)
#    randomMax = rand(50) + 50
#    random = rand(100)
#    ptainstructorId = ps[rand(ps.length)]
#    teacherId = ts[rand(ts.length)]
#    ptainstructor = Ptainstructor.find_by_id(ptainstructorId)
#    teacher = Teacher.find_by_id(teacherId)
#
#    semester.courses.create(
#      name: "#{isemester} Course #{t+1}",
#      description: "#{isemester} course ##{t+1}",
#      sunday: 1,
#      wednesday: 1,
#      start_time: "#{t+1}:00pm",
#      end_time: "#{t+1}:00pm",
#      grade_range: "#{randomGrade}",
#      class_min: randomMin,
#      class_max: randomMax,
#      number_of_classes: randomMin,
#      fee_per_meeting: random,
#      fee_for_additional_materials: random,
#      total_fee: random,
#      ptainstructor: ptainstructor,
#      teacher: teacher,
#    )
#  end
end







