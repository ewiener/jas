# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Semester.create(name: "Fall 2012",
                start_date: "08/22/2012",
                end_date: "12/24/2012",
                lottery_deadline: "08/22/2012",
                registration_deadline: "08/22/2012",
                fee: 100.0)
Semester.create(name: "Spring 2012",
                start_date: "01/22/2012",
                end_date: "05/13/2012",
                lottery_deadline: "01/22/2012",
                registration_deadline: "01/22/2012",
                fee: 200.0)
@semester = Semester.find_by_id(1)
@semester.courses.create(name: "CS169",
              number_of_classes: 300,
              sunday: false,
              monday: true,
              tuesday: false,
              wednesday: true,
              thursday: false,
              friday: false,
              saturday: false,
              start_time_hour: 12,
              start_time_minute: 22,
              start_time_type: 0,
              end_time_hour: 4,
              end_time_minute: 30,
              end_time_type: 0,
              class_min: 10,
              class_max: 100,
              grade_range: "K-4",
              fee_per_meeting: 200.0,
              total_fee: 500.0)




