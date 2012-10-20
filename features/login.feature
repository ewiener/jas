Feature: Create Login to the PTA Database

   As an administrator
   So that I can manage the sessions (login requires authentication)
   I want to create a login for the database

Background: Populate login with username and password
   
   Given the following usernames and passwords exist:
   | admin         | admin_password |
   | pta_instructor| pta_password   |

Scenario: Login as an administrator
   Given I am at the login page
   When I fill in "Username" with "admin"
   And I fill "Password" with "admin_password"
   And I select "Login"
   Then I should be on the "Jefferson PTA - Sessions" home page
   Then I should see "Create New Session" link 

Scenario: Login as PTA instructor
   Given I am at the login page
   When I fill in "Username" with "pta_instructor"
   And I fill "Password" with "pta_password"
   And I select "Login"
   Then I should be on the "Jefferson PTA - Sessions" home page
   Then I should not see "Create New Session" link

Scenario: Login with wrong password
   Given I am at the login page
   When I fill in "Username" with "admin"
   And I fill in "Password" with "random"
   And I select "Login"
   Then I should be on the login page
   And "Username" should be ""
   And "Password" should be ""

Scenario: Login with wrong username
   Given I am an admin at the login page
   When I fill in "Username" with "random"
   And I fill in "Password" with "admin_password"
   And I select "Login"
   Then I should be on the login page
   And "Username" should be ""
   And "Password" should be ""






