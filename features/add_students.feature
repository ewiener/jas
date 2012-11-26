Feature: Assign students to classes

  As an administrator
  So that I can schedule students to classes
  I want to add student info to the database
  
Background: populate db with a single class session

  Given the following sessions exist:
  | name        | start_date    | end_date  | lottery_deadline  | registration_deadline |
  | Fall 2011   | 09/15/2011    | 12/15/2011| 09/09/2011        | 09/14/2011            |
  
  Given the following classrooms are in the database:
  | name    | grade | classroom | semester  |
  | joe     | 1     | Room 4    | Fall 2011 |
  
  Given the following students are in the database:
  | first_name  | last_name | grade | parent_phone  | parent_phone2 | parent_name   | parent_email  | health_alert  | semester  | teacher   |
  | Abby        | Davis     | K     | 6193244565    | 6194354324    | Virginia      | v@gmail.com   | no peanuts    | Fall 2011      | joe       |

  
Scenario: add student to db correctly
  Given I am on the "Fall 2011" Students home page
  And I follow "Add New Student"
  Then I should be on the "Fall 2011" New Students Page
  And I fill in the new student form correctly with name "Jimmy"
  And I press "Register Student"
  Then I should be on the "Fall 2011" Students home page
  And I should see "Jimmy"
  
Scenario: add student incorrectly, should redirect to same page
  Given I am on the "Fall 2011" Students home page
  And I follow "Add New Student"
  Then I should be on the "Fall 2011" New Students Page
  And I press "Register Student"
  Then I should be on the "Fall 2011" New Students Page

Scenario: update student correctly
  Given I am on the "Fall 2011" Students home page
  And I press "Edit"
  Then I should be on the "Fall 2011" "Abby" Edit Students Page
  And I fill in "First Name" with "Mary"
  And I press "Update Student"
  Then I should be on the "Fall 2011" Students home page
  And I should see "Mary"

Scenario: update student incorrectly
  Given I am on the "Fall 2011" Students home page
  And I press "Edit"
  Then I should be on the "Fall 2011" "Abby" Edit Students Page
  And I fill in "First Name" with ""
  And I press "Update Student"
  Then I should be on the "Fall 2011" "Abby" Edit Students Page

Scenario: Delete student
  Given I am on the "Fall 2011" Students home page
  And I press "Delete"
  Then I should be on the "Fall 2011" Students home page
  And I should see "successfully deleted"

Scenario: Attempt to access a semester that does not exist
  Given I am on the "Fall 2111" Students home page
  Then I should be on the home page
  
Scenario: Attempt to add new student in invalid semester
  Given I am on the "Fall 2111" New Students Page
  Then I should be on the home page
  And I should see "Error: Unable to find the semester for the student."
  
Scenario: Attempt to edit a student in an invalid semester
  Given I am on the "Fall 2111" "Abby" Edit Students Page
  Then I should be on the home page
