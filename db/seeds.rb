# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

semesters = ['Fall 2012', 'Spring 2012', 'Winter 2012']
semesters.each do |my_semester|
  # Adding Semesters
  Semester.create(
    name: my_semester,
    start_date: "08/22/2012",
    end_date: "12/24/2012",
    lottery_deadline: "08/22/2012",
    registration_deadline: "08/22/2012",
    fee: 1000.0
  )

  # Adding PTA Instructors
  semester = Semester.find_by_name(my_semester)
  number_of_ptainstructors = 3
  number_of_ptainstructors.times do |t|
    semester.ptainstructors.create(
      name: "#{my_semester} PTA Instructor #{t+1}",
      email: "ptainstructor#{t+1}@gmail.com",
      phone: "1234567890",
      address: "An address somewhere",
    )
  end

  # Adding Teachers
  grades = 'K,1,2,3,4,5'.split(',')
  randomGrade = grades[rand(grades.length)]
  number_of_teachers = 3
  number_of_teachers.times do |t|
    semester.teachers.create(
      name: "#{my_semester} Teacher #{t+1}",
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
#      name: "#{my_semester} Course #{t+1}",
#      description: "#{my_semester} course ##{t+1}",
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







