Feature: Adding classroom teachers to the database

  As an administrator
  So that I can publish rosters for the classroom teachers
  I want to add classroom teachers to the database

Background: populate db with a single class session

  Given the following sessions exist:
  | name        | start_date    | end_date  | lottery_deadline  | registration_deadline | dates_with_no_classes |
  | Fall 2011   | 09/15/2011    | 12/15/2011| 09/09/2011        | 09/14/2011            | 11/13/2011            |
  
  Given the following classrooms are in the database:
  | name    | grade | classroom | semester  |
  | joe     | 1     | Room 4    | Fall 2011 |

Scenario: Delete classrom teacher/location
  Given I am on the "Fall 2011" Classroom Teachers home page
  And I press "Delete"
  Then I should be on the "Fall 2011" Classroom Teachers home page
  And I should see "was successfully deleted from the database."

Scenario: Attempt to access a semester that does not exist
  Given I am on the "Fall 2111" Classroom Teachers home page
  Then I should be on the home page
  
Scenario: Edit classroom teacher/location
  Given I am on the "Fall 2011" Classroom Teachers home page
  And I press "Edit"
  Then I should be on the "Fall 2011" "joe" Classroom Teachers edit page
  And I fill in "Location" with "Room 500"
  And I press "Update"
  Then I should be on the "Fall 2011" Classroom Teachers home page

Scenario: Adding new classroom teacher from homepage
  Given I am on the "Fall 2011" Session Name Page
  And I follow "Teachers/Classrooms"
  Then I am on the "Fall 2011" Classroom Teachers home page
  And I follow "Add New Classroom Teacher"
  Then I should be on the "Fall 2011" Add New Classroom Page
  When I fill in the new classroom form correctly with classroom "Gym"
  And press "Add Classroom Teacher"
  Then I should be on the "Fall 2011" Classroom Teachers home page
  And I should see "Gym"
  
Scenario: Adding from the create class page
  Given I am on the "Fall 2011" new Course Name Page
  And I follow "Add New Location"
  Then I should be on the "Fall 2011" Add New Classroom Page
  When I fill in the new classroom form correctly with classroom "Room 10"
  And press "Add Classroom Teacher"
  Given I am on the "Fall 2011" new Course Name Page
  And the "locations" drop-down should contain the option "Room 10"
  
Scenario: Cancel adding new classroom teacher from homepage
  Given I am on the "Fall 2011" Session Name Page
  And I follow "Teachers/Classrooms"
  Then I am on the "Fall 2011" Classroom Teachers home page
  And I follow "Add New Classroom Teacher"
  Then I should be on the "Fall 2011" Add New Classroom Page
  When I fill in the new classroom form correctly with classroom "Auditorium"
  And follow "Cancel"
  Then I should be on the "Fall 2011" Session Name Page
  And the "locations" drop-down should not contain the option "Auditorium"
  
Scenario: Cancel adding from the create class page
  Given I am on the "Fall 2011" new Course Name Page
  And I follow "Add New Location"
  Then I should be on the "Fall 2011" Add New Classroom Page
  When I fill in the new classroom form correctly with classroom "Room 1"
  And follow "cancel"
  Then I should be on the "Create New Class" page
  And the "locations" drop-down should not contain the option "Room 1"
