Feature: Register and assign students to classes

  As an administrator
  So that I can schedule students to classes
  I want to add student registration info to the database
  
Background: populate db with a single class session

  Given the following sessions exist:
  | name        | start_date    | end_date  | lottery_deadline  | registration_deadline |
  | Fall 2011   | 09/15/2011    | 12/15/2011| 09/09/2011        | 09/14/2011            |
  
  Given the following usernames and passwords exist:
  | username       | password | password_confirmation |
  | admin          | asdf     | asdf                  |

  Given I am on the login page
  And I log in correctly as "admin"
  
  
Scenario: Create a student without havign a classroom teacher in the database
  Given I am on the "Fall 2011" Students home page
  And I follow "Add New Student"
  Then I should be on the "Fall 2011" New Students Page
  And I press "Register Student"
  Then I should be on the "Fall 2011" New Students Page
