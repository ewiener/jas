Feature: Adding classroom teachers to the database

  As an administrator
  So that I can publish rosters for the classroom teachers
  I want to add classroom teachers to the database

Background: populate db with a single class session

  Given the following sessions exist:
  | name        | start_date    | end_date  | lottery_deadline  | registration_deadline | dates_with_no_classes |
  | Fall 2011   | 09/15/2011    | 12/15/2011| 09/09/2011        | 09/14/2011            | 11/13/2011            |

Scenario: Adding new classroom teacher from homepage
  Given I am on the "Fall 2011" Session Name Page
  And I follow "Jefferson Classrooms"
  Then I am on the "Fall 2011" Classroom Teachers home page
  And I follow "Add New Classroom Teacher"
  Then I should be on the "Fall 2011" Add New Classroom Page
  When I fill in the new classroom form correctly with classroom "Gym"
  And press "Add Classroom Teacher"
  Then I should be on the "Fall 2011" Classroom Teachers home page
  And I should see "Gym"
  
Scenario: Adding from the create class page
  Given that I am on the "Create New Class" page
  And I click "Add New Location"
  Then I should be on the "Add New Classroom" Page
  When I fill in the new classroom form correctly with classroom "Gym"
  And press "create"
  Then I should be on the "Create New Class" page
  And I should be able to select the added location
  
Scenario: Cancel adding new classroom teacher from homepage
  Given I am on the "Fall 2011" Session Name Page
  And I follow "Jefferson Classrooms"
  Then I am on the "Fall 2011" Classroom Teachers home page
  And I follow "Add New Classroom Teacher"
  Then I should be on the "Fall 2011" Add New Classroom Page
  When I fill in the form
  And press "cancel"
  Then I should be on the "Fall 2011" Session Name Page
  And I should not see the added teacher
  
Scenario: Cancel adding from the create class page
  Given that I am on the "Create New Class" page
  And I click "Add New Location"
  Then I should be on the "Add New Classroom" Page
  When I fill in the form
  And press "cancel"
  Then I should be on the "Create New Class" page
  And I should not be able to select the added location
