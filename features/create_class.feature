Feature: Add class to the session
  
  As an administrator
  So that I can schedule classes for the session
  I want to add classes to the new session
  
Background: populate db

  Given the following sessions exist:
  | Fall 2011   |

Scenario: create new class
  Given I am on the Session Name Page
  And the "Session Name" is "Fall 2012"
  And I follow "add new"
  Then I should be on the Create Class Page
  When I fill in "Class Name" with "Math"
  And I select "create"
  Then I should be on the Session Name Page
  And I should see the class "Math"
  
Scenario: cancel create new class
  Given I am on the Session Name Page
  And the "Session Name" is "Fall 2012"
  And I follow "add new"
  Then I should be on the Create Class Page
  When I fill in "Class Name" with "Math"
  And I select "cancel"
  Then I should be on the Are you sure? Page
  When I click "yes"
  Then I should be on the Session Name Page
  And no new classes should be added

Scenario: Recover class to be created
  Given I am on the Create Class Page
  When I fill in "Class Name" with "Math"
  And I select "cancel"
  Then I should be on the Are you sure? Page
  When I click "no"
  Then I should be on the Create Class Page
  And "Class Name" should be "Math"
  
  
