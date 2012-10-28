Feature: Adding classroom teachers to the database

  As an administrator
  So that I can publish rosters for the classroom teachers
  I want to add classroom teachers to the database
  
Scenario: Adding new classroom teacher from homepage
  Given that I am on the "Class Teachers" home page
  And I click "Add New"
  Then I should be on the "Add New Classroom" Page
  When I fill in the form
  And press "create"
  Then I should be on the "PTA Instructor" home page
  And I should see the added teacher
  
Scenario: Adding from the create class page
  Given that I am on the "Create New Class" page
  And I click "Add New Location"
  Then I should be on the "Add New Classroom" Page
  When I fill in the form
  And press "create"
  Then I should be on the "Create New Class" page
  And I should be able to select the added location
  
Scenario: Cancel adding new classroom teacher from homepage
  Given that I am on the "Class Teachers" home page
  And I click "Add New"
  Then I should be on the "Add New Classroom" Page
  When I fill in the form
  And press "cancel"
  Then I should be on the "PTA Instructor" home page
  And I should not see the added teacher
  
Scenario: Cancel adding from the create class page
  Given that I am on the "Create New Class" page
  And I click "Add New Location"
  Then I should be on the "Add New Classroom" Page
  When I fill in the form
  And press "cancel"
  Then I should be on the "Create New Class" page
  And I should not be able to select the added location
