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




