Feature: Add class to the session
  
  As an administrator
  So that I can schedule classes for the session
  I want to add classes to the new session

Background: previous sessions have been added to the database
  
  Given the following sessions exist:
    | name        | start_date    | end_date  | lottery_deadline  | registration_deadline | fee |
    | Fall 2011   | 09/15/2011    | 12/15/2011| 09/09/2011        | 09/14/2011            | 35  |
    | Spring 2012 | 02/15/2012    | 06/15/2012| 01/21/2012        | 01/31/2012            | 29  |
    | Fall 2012   | 09/15/2012    | 12/15/2012| 09/09/2012        | 09/14/2012            | 31  |
    
  Given the following pta instructors exist:
  | first_name | last_name | email     | phone     | address       | bio       | semester  |
  | teacher1   | lastname1 | jim@a.com | 4156891212| 12 Cedar Lane | Some info | Spring 2012 |
  | teacher2   | lastname2 | amy@a.com | 4156891212| 12 Cedar Lane | Some info | Spring 2012 |
  
  Given the following usernames and passwords exist:
  | username       | password | password_confirmation |
  | admin          | asdf     | asdf                  |

  Given I am on the login page
  And I log in correctly as "admin"
  
  
Scenario: Attempt to add a course when no teachers in db
  Given I am on the "Fall 2011" Session Name Page
  #the Add + button should be invalid
