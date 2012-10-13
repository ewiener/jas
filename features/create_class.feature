Feature: Add class to the session
  
  As an administrator
  So that I can schedule classes for the session
  I want to add classes to the new session
  
Background: populate db with a single class session

  Given the following sessions exist:
  | Fall 2011   |

Scenario: Create New Class
  Given I am on the Home Page
  And I click "Fall 2012"
  Then I should be on the Session Name Page
  And the Session Name should be "Fall 2012"
  When I follow "Add New"
  Then I should be on the Create Class Page
  When I fill in "Class Name" with "Math"
  And I select "Create"
  Then I should be on the Session Name Page
  And I should see the class "Math"
  
Scenario: Cancel Create New Class
  Given I am on the Home Page
  And I click "Fall 2012"
  Then I should be on the Session Name Page
  And the "Session Name" should be "Fall 2012"
  When I follow "Add New"
  Then I should be on the Create Class Page
  When I fill in "Class Name" with "Math"
  And I select "Cancel"
  Then I should be on the Are You Sure? Page
  When I click "Yes"
  Then I should be on the Session Name Page
  And no new classes should be added

Scenario: Recover From Clicking Cancel
  Given I am on the Create Class Page
  When I fill in "Class Name" with "Math"
  And I select "Cancel"
  Then I should be on the Are You Sure? Page
  When I click "No"
  Then I should be on the Create Class Page
  And "Class Name" should be "Math"
  
  
