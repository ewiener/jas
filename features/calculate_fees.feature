Feature: Calculate Fees Feature

  As an administrator
  So that I can give students' parents the fees
  I want to be able to calculate student fees automatically based on the classes they are enrolled in
  
Background: populate db with all information for a session

  Given the following sessions exist:
  | name        | start_date    | end_date  | lottery_deadline  | registration_deadline | fee |
  | Fall 2011   | 09/15/2011    | 12/15/2011| 09/09/2011        | 09/14/2011            | 15  |
  
  Given the following classrooms are in the database:
  | name    | grade | classroom | semester  |
  | joe     | 1     | Room 4    | Fall 2011 |
  | jim     | 4     | Room 2    | Fall 2011 |
  
  Given the following pta instructors exist:
  | first_name | last_name | email     | phone     | address       | bio       | semester  |
  | Jim        | Dean      | jim@a.com | 4156891212| 12 Cedar Lane | Some info | Fall 2011 |
  | Amy        | Tsao      | amy@a.com | 4156891212| 12 Cedar Lane | Some info | Fall 2011 |
  | Mia        | Mama      | mia@a.com | 4156891212| 12 Cedar Lane | Some info | Fall 2011 |
  
  Given the following courses have been added:
    | name    | semester      | description | start_time        | class_min | class_max | grade_range   | fee_per_meeting   | fee_for_additional_materials  | monday    | tuesday   | wednesday | thursday  | friday    | end_time     | sunday | saturday | number_of_classes | total_fee | ptainstructor | teacher   |
    | Artistic Dance     | Fall 2011     | art class   | 2:10pm            | 5         | 15        | K-5           | 10                | 15                            | true      | false       | false     | false     | false     | 3:10pm     | false | false | 12 | 122 | Jim | Room 4 |
  
  Given the following students are in the database:
  | first_name  | last_name | grade | parent_phone  | parent_phone2 | parent_name   | parent_email  | health_alert  | semester  | teacher   |
  | Abby        | Davis     | K     | 6193244565    | 6194354324    | Virginia      | v@gmail.com   | no peanuts    | Fall 2011      | joe       |
  
  Given the following usernames and passwords exist:
  | username       | password | password_confirmation |
  | admin          | asdf     | asdf                  |

  Given I am on the login page
  And I log in correctly as "admin"

@javascript  
Scenario: See total Fee calculated after registering to courses with no scholarship
  Given I am on the "Fall 2011" "Abby" Edit Students Page
  And I fill out the registration form correctly with class "Artistic Dance", "None" scholarship, "Pick Up" dismissal, and "Enrolled"
  And I press "Add New Enrollment"
  And I should see "$122.00"
  Then I should see "$137.00"
  
@javascript  
Scenario: See total Fee calculated after registering to courses with full scholarship
  Given I am on the "Fall 2011" "Abby" Edit Students Page
  And I fill out the registration form correctly with class "Artistic Dance", "Full" scholarship, "Pick Up" dismissal, and "Enrolled"
  And I press "Add New Enrollment"
  Then I should see "$15.00"

@javascript
Scenario: See total Fee calculated before registering to courses should have a fee of the registration fee
  Given I am on the "Fall 2011" "Abby" Edit Students Page
  Then I should see "$15.00"
