Feature: Adding/Editing a session

  As an administrator
  So that I can keep track of classes/PTA Instructors/Students/Parents
  I want to create/edit sessions in the database

Background: previous sessions have been added to the database
  
  Given the following sessions exist:
  | Fall 2011   |
  | Spring 2012 |
  
  Given the following classes have been added:
  | Art     | Spring 2012   |
  | Science | Spring 2012   |
  
  And I am on the Home Page


Scenario: Create new session
  Given I am an administrator
  When I click "Create New..."
  Then I am on the Session Name Page
  And I should see no populated classes
  When I fill in "Session Name" with "Fall 2012"
  And I fill in "Start Date" with 
  And I fill in "End Date" with 
  And I click "add new"
  Then I should be on the Home
  And I should see the semester "Fall 2012"
  And I should see the semester "Spring 2012"
  And I should see the semester "Fall 2011"
  
Scenario: Import classes from last semester
  Given I am on the Session Name Page
  And the "Session Name" is Fall 2012
  When I follow "import"
  Then I should see the class "Art"
  And I should see the class "Science"
  When "Art" is clicked
  And "Science" is clicked
  And I follow "import"
  Then I should be on the Session Name Page
  And I should see the class "Art"
  And I should see the class "Science"

Scenario: Cancel import of classes from last semester
  Given I am on the Session Name Page
  And the "Session Name" is Fall 2012
  When I follow "import"
  Then I should see the class "Art"
  And I sohuld see the class "Science"
  When I click "import"
  Then I should be on the Session Name Page
  And no new classes should be added
  
Scenario: Update semester
  Given I am on the Home Page
  And I click on "Spring 2012"
  Then I should be on the Session Name Page
  And the "Session Name" is "Spring 2012"
  Then I should see the class "Art"
  And I should see the class "Science"
  
