Feature: Veryify item not referenced before deletion

  As an administrator
  So that I can manage the database
  I want to only delete items that are not referenced by other items
  
Background: populate db with all information for a session

  Given the following sessions exist:
  | name        | start_date    | end_date  | lottery_deadline  | registration_deadline |
  | Fall 2011   | 09/15/2011    | 12/15/2011| 09/09/2011        | 09/14/2011            |
  
  Given the following classrooms are in the database:
  | name    | grade | classroom | semester  |
  | Bob Barker     | 1     | Room 4    | Fall 2011 |
  | Pat Sajak     | 1     | Room 2    | Fall 2011 |
  
  Given the following pta instructors exist:
  | first_name | last_name | email     | phone     | address       | bio       | semester  |
  | James        | Dean      | jim@a.com | 4156891212| 12 Cedar Lane | Some info | Fall 2011 |
  
  Given the following courses have been added:
    | name    | semester      | description | start_time        | class_min | class_max | grade_range   | fee_per_meeting   | fee_for_additional_materials  | monday    | tuesday   | wednesday | thursday  | friday    | end_time     | sunday | saturday | number_of_classes | total_fee | ptainstructor | teacher   |
    | Artistic Dance     | Fall 2011     | art class   | 2:10pm            | 5         | 15        | K-5           | 10                | 15                            | true      | false       | false     | false     | false     | 3:10pm     | false | false | 12 | 122 | James | Room 4 |
  
  Given the following students are in the database:
  | first_name  | last_name | grade | parent_phone  | parent_phone2 | parent_name   | parent_email  | health_alert  | semester  | teacher   |
  | Abby        | Davis     | K     | 6193244565    | 6194354324    | Virginia      | v@gmail.com   | no peanuts    | Fall 2011      | Pat Sajak      |
  
Scenario: Verify pta instructor cannot be deleted, because referenced
  Given I am on the "Fall 2011" PTA Instructor home page
  Then I should see "Referenced"
  
Scenario: Verify classroom teacher cannot be deleted, because referenced twice
  Given I am on the "Fall 2011" Classroom Teachers home page
  Then I should see "Referenced" 2 times
  
Scenario: Delete student, then check if that classroom teacher can be deleted
  Given I am on the "Fall 2011" Students home page
  And I press "Delete"
  Given I am on the "Fall 2011" Classroom Teachers home page
  Then I should see "Referenced" 1 time
  And I press "Delete"
  
Scenario: Delete course, then check if that classroom teacher and the pta instructor can be deleted
  Given I am on the "Fall 2011" Course Page
  And I press "Delete"
  Given I am on the "Fall 2011" Classroom Teachers home page
  Then I should see "Referenced" 1 time
  And I press "Delete"
  Given I am on the "Fall 2011" PTA Instructor home page
  And I should not see "Referenced"
  And I press "Delete"
  
Scenario: Delete both course and student, verify that all pta instructors and classroom teachers can be deleted
  Given I am on the "Fall 2011" Students home page
  And I press "Delete"
  Given I am on the "Fall 2011" Course Page
  And I press "Delete"
  Given I am on the "Fall 2011" Classroom Teachers home page
  And I should not see "Referenced"
  Given I am on the "Fall 2011" PTA Instructor home page
  And I should not see "Referenced"
