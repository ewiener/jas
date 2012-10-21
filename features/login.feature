Feature: Create Login to the PTA Database

   As an administrator
   So that I can manage the sessions (login requires authentication)
   I want to create a login for the database

Background: Populate login with username and password
   
   Given the following usernames and passwords exist:
   | username       | password          |
   | admin          | admin_password    |
   | pta_instructor | pta_password      |

Scenario: Login as an administrator
   Given I am on the login page
   When I fill in "username" with "admin"
   And I fill in "password" with "admin_password"
   And I press "Login"
   Then I should be on the home page
   Then I should see "Create New Session"

Scenario: Login as PTA instructor
   Given I am on the login page
   When I fill in "username" with "pta_instructor"
   And I fill in "password" with "pta_password"
   And I press "Login"
   Then I should be on the home page
   Then I should not see "Create New Session"

Scenario: Login with wrong password
   Given I am on the login page
   When I fill in "username" with "admin"
   And I fill in "password" with "random"
   And I press "Login"
   Then I should be on the login page
   And the "username" field should contain ""
   And the "password" field should contain ""

Scenario: Login with wrong username
   Given I am an admin
   And I am on the login page
   When I fill in "username" with "random"
   And I fill in "password" with "admin_password"
   And I press "Login"
   Then I should be on the login page
   And the "username" field should contain ""
   And the "password" field should contain ""
