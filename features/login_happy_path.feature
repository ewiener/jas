Feature: Create Login to the PTA Database

   As an administrator
   So that I can manage the sessions securely
   I want to create a login for the database

Background:

  Given the following sessions exist:
    | name        | start_date    | end_date  | lottery_deadline  | registration_deadline | fee |
    | Fall 2011   | 09/15/2011    | 12/15/2011| 09/09/2011        | 09/14/2011            | 35  |

#Background: Populate login with username and password
#   
#   Given the following usernames and passwords exist:
#   | username       | password          |
#   | admin          | admin_password    |
#   | pta_instructor | pta_password      |

Given I am on the login page
And I log in correctly as "admin"
Then I should be on the home page
And I should see "Successfully logged in as admin"

Scenario: Access the home page
   Given I am on the home page
   Then I should be on the home page

Scenario: Access classroom teachers home page
   Given I am on the "Fall 2011" Classroom Teachers home page
   Then I should be on the "Fall 2011" Classroom Teachers home page
   
Scenario: Access the courses home page
   Given I am on the "Fall 2011" Course page
   Then I should be on the "Fall 2011" Course page
   
Scenario: Access the home page
   Given I am on the "Fall 2011" PTA Instructor home page
   Then I should be on the "Fall 2011" PTA Instructor home page

Scenario: Access the students home page
   Given I am on the "Fall 2011" Students home page
   Then I should be on the "Fall 2011" Students home page

#Scenario: Login as an administrator
#   Given I am on the login page
#   When I fill in "username" with "admin"
#   And I fill in "password" with "admin_password"
#   And I press "Login"
#   Then I should be on the home page
#   Then I should see "Create New Session"
#
#Scenario: Login as PTA instructor
#   Given I am on the login page
#   When I fill in "username" with "pta_instructor"
#   And I fill in "password" with "pta_password"
#   And I press "Login"
#   Then I should be on the home page
#   Then I should not see "Create New Session"
#
#Scenario: Login with wrong password
#   Given I am on the login page
#   When I fill in "username" with "admin"
#   And I fill in "password" with "random"
#   And I press "Login"
#   Then I should be on the login page
#   And the "username" field should contain ""
#   And the "password" field should contain ""
#
#Scenario: Login with wrong username
#   #Given I am an admin
#   And I am on the login page
#   When I fill in "username" with "random"
#   And I fill in "password" with "admin_password"
#   And I press "Login"
#   Then I should be on the login page
#   And the "username" field should contain ""
#   And the "password" field should contain ""
