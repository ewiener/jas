Feature: Calculate Fees Feature

  As an administrator
  So that I can give students' parents the fees
  I want to be able to calculate student fees automatically based on the classes they are enrolled in
  
Background: populate db with all information for a session

  Given the following sessions exist:
  | name        | start_date    | end_date  | lottery_deadline  | registration_deadline |
  | Fall 2011   | 09/15/2011    | 12/15/2011| 09/09/2011        | 09/14/2011            |
  
  Given the following classrooms are in the database:
  | name    | grade | classroom | semester  |
  | joe     | 1     | Room 4    | Fall 2011 |
  | jim     | 4     | Room 2    | Fall 2011 |
  
  Given the following pta instructors exist:
  | name    | email     | phone     | address       | bio       | semester  |
  | Jim     | jim@a.com | 4156891212| 12 Cedar Lane | Some info | Fall 2011 |
  | Amy     | amy@a.com | 4156891212| 12 Cedar Lane | Some info | Fall 2011 |
  | Mia     | mia@a.com | 4156891212| 12 Cedar Lane | Some info | Fall 2011 |
  
  Given the following courses have been added:
    | name    | semester      | description | start_time        | class_min | class_max | grade_range   | fee_per_meeting   | fee_for_additional_materials  | monday    | tuesday   | wednesday | thursday  | friday    | end_time     | sunday | saturday | number_of_classes | total_fee | ptainstructor | teacher   |
    | Artistic Dance     | Fall 2011     | art class   | 2:10pm            | 5         | 15        | K-5           | 10                | 15                            | true      | false       | false     | false     | false     | 3:10pm     | false | false | 12 | 122 | Jim | Room 4 |
  
  Given the following students are in the database:
  | first_name  | last_name | grade | parent_phone  | parent_phone2 | parent_name   | parent_email  | health_alert  | semester  | teacher   |
  | Abby        | Davis     | K     | 6193244565    | 6194354324    | Virginia      | v@gmail.com   | no peanuts    | Fall 2011      | joe       |

  Given PENDING I am on the register courses home page
  
Scenario: See total Fee calculated after registering to courses
  Given PENDING I am on the "Fall 2011" "Abby" Student page
  Then PENDING I should see a total fee of "115"
  And PENDING I should see a course fee of "100"

Scenario: New students should have a fee of zero
  Given PENDING I am on the "Fall 2011" Students home page
  And PENDING I follow "Add new Student"
  Then PENDING I should see a fee of 0
