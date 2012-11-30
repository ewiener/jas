Feature: Import all information from previous semester

  As an administrator
  So that I can more easily create the new session
  I want to import all information from the previous session
  
Background: populate db with all information for a session

  Given the following sessions exist:
  | name        | start_date    | end_date  | lottery_deadline  | registration_deadline |
  | Fall 2011   | 09/15/2011    | 12/15/2011| 09/09/2011        | 09/14/2011            |
  
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
  
  Given I am on the home page
  And I follow "Create New Session"
  Then I am on the Session Name Page
  And I fill in the new session form correctly with name "Spring 2012"
  And I press "Save Semester"
  Then I should be on the home page
  And I should see "Spring 2012"
  Given I am on the "Spring 2012" Session Name Page
  And I press "Import"
  
Scenario: verify pta instructors imported
  When I follow "PTA Instructors"
  Then I should see "Jim"
  And I should see "Amy"
  And I should see "Mia"

Scenario: verify classroom teachers imported
  When I follow "Teachers/Classrooms"
  Then I should see "joe"
  And I should see "jim"
  And I should not see "Mia"

Scenario: verify courses imported
  Given I am on the "Spring 2012" Course home page
  And I should see "Artistic Dance"

Scenario: verify students imported
  When I follow "Students"
  And I should see "Abby"
  
  
