Feature: Adding PTA instructors to the database

  As an administrator
  So that I can create rosters for the PTA instructors and schedule the PTA instructors
  I want to add PTA instructors to the database

Background: 

Scenario: Creating from the PTA Instructor home page
  Given that I am on the "PTA Instructor" home page
  And I click "Add New"
  Then I should be on the "Add New PTA Teacher" Page
  When I fill in the form
  And press "create"
  Then I should be on the "PTA Instructor" home page
  And I should see the added teacher
  
Scenario: Creating from the create class page
  Given that I am on the "Create New Class" page
  And I click "Add New PTA Instructor"
  Then I should be on the "Add New PTA Teacher" Page
  When I fill in the form
  And press "create"
  Then I should be on the "Create New Class" page
  And I should be able to select the added teacher
  
Scenario: Cancel creating from the PTA Instructor home page
  Given that I am on the "PTA Instructor" home page
  And I click "Add New"
  Then I should be on the "Add New PTA Teacher" Page
  When I fill in the form
  And press "cancel"
  Then I should be on the "PTA Instructor" home page
  And I should not see the added teacher
  
Scenario: Cancel creating from the create class page
  Given that I am on the "Create New Class" page
  And I click "Add New PTA Instructor"
  Then I should be on the "Add New PTA Teacher" Page
  When I fill in the form
  And press "cancel"
  Then I should be on the "Create New Class" page
  And I should not be able to select the added teacher
