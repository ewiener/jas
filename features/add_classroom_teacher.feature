Feature: Adding classroom classrooms to the database

  As an administrator
  So that I can publish rosters for the classroom classrooms
  I want to add classroom classrooms to the database

Background: populate db with a single class session

  Given the following sessions exist:
  | name        | start_date    | end_date  | lottery_deadline  | registration_deadline |
  | Fall 2011   | 09/15/2011    | 12/15/2011| 09/09/2011        | 09/14/2011            |
  
  Given the following classrooms are in the database:
  | name    | grade | classroom | semester  |
  | joe     | 1     | Room 4    | Fall 2011 |
  
  Given the following usernames and passwords exist:
  | username       | password | password_confirmation |
  | admin          | asdf     | asdf                  |

  Given I am on the login page
  And I log in correctly as "admin"
  Given I am on the "Fall 2011" Session Name Page
  And I follow "Classrooms/Classrooms"
  Then I should be on the "Fall 2011" Classroom Classrooms home page

Scenario: Create invalid classroom classroom:
  Given I am on the "Fall 2011" Classroom Classrooms home page
  And I follow "Add New Classroom Classroom"
  Then I should be on the "Fall 2011" Add New Classroom Page
  And press "Add Classroom Classroom"
  Then I should be on the "Fall 2011" Add New Classroom Page
  And I should see "Invalid empty string for name."
  
Scenario: Update classroom classroom invalidly
  Given I am on the "Fall 2011" Classroom Classrooms home page
  And I press "Edit"
  And I fill in "classroom_name" with ""
  And I press "Finish Editing Classroom Classroom"
  And I should see "Invalid empty string for name."

Scenario: Delete classrom classroom/location
  Given I am on the "Fall 2011" Classroom Classrooms home page
  And I press "Delete"
  Then I should be on the "Fall 2011" Classroom Classrooms home page
  And I should see "was successfully deleted from the database."

Scenario: Attempt to access a semester that does not exist
  Given I am on the "Fall 2111" Classroom Classrooms home page
  Then I should be on the home page
  
Scenario: Edit classroom classroom/location
  Given I am on the "Fall 2011" Classroom Classrooms home page
  And I press "Edit"
  Then I should be on the "Fall 2011" "joe" Classroom Classrooms edit page
  And I fill in "Classroom" with "Room 500"
  And I press "Finish Editing Classroom Classroom"
  Then I should be on the "Fall 2011" Classroom Classrooms home page

Scenario: Adding new classroom classroom from homepage
  Then I am on the "Fall 2011" Classroom Classrooms home page
  And I follow "Add New Classroom Classroom"
  Then I should be on the "Fall 2011" Add New Classroom Page
  When I fill in the new classroom form correctly with classroom "Gym"
  And press "Add Classroom Classroom"
  Then I should be on the "Fall 2011" Classroom Classrooms home page
  And I should see "Gym"

Scenario: Cancel adding new classroom classroom from homepage
  Then I am on the "Fall 2011" Classroom Classrooms home page
  And I follow "Add New Classroom Classroom"
  Then I should be on the "Fall 2011" Add New Classroom Page
  When I fill in the new classroom form correctly with classroom "Auditorium"
  And follow "Cancel"
  Then I should be on the "Fall 2011" Classroom Classrooms home page
  And the "locations" drop-down should not contain the option "Auditorium"
