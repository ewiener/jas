Feature: Add class to the session
  
  As an administrator
  So that I can schedule classes for the session
  I want to add classes to the new session
  
Background: populate db with a single class session

  Given the following sessions exist:
  | name        | start_date    | end_date  | lottery_deadline  | registration_deadline | dates_with_no_classes |
  | Fall 2011   | 09/15/2011    | 12/15/2011| 09/09/2011        | 09/14/2011            | 11/13/2011            |

Scenario: Create New Class
  Given I am on the home page
  And I follow "Fall 2011"
  Then I should be on the "Fall 2011" Session Name Page
  When I follow "Add +"
  Then I should be on the "Fall 2011" Create Class Page
  When I fill in "Course Name" with "Math"
  And I fill in "Description" with "A class about numbers"
  And I check "course_wednesday"
  And I fill in "Start Time" with "2:10pm"
  And I fill in "End Time" with "3:10pm"
  And I fill in "Min. Class Size" with "1"
  And I fill in "Max. Class Size" with "20"
  And I fill in "Eligible Grades" with "1-5"
  And I fill in "Price Per Student Per Meeting" with "10"
  And I fill in "Fee for Additional Materials" with "15"
  And I press "Add New Course"
  Then I should be on the "Fall 2011" Session Name Page
  And I should see "Math"
  
Scenario: Cancel Create New Class
  Given I am on the home page
  And I follow "Fall 2011"
  Then I should be on the "Fall 2011" Session Name Page
  When I follow "Add +"
  Then I should be on the "Fall 2011" Create Class Page
  When I fill in "Course Name" with "Math"
  And I press "Cancel"
  #Then I should be on the Are You Sure? Page
  #When I press "Yes"
  Then I should be on the "Fall 2011" Session Name Page
  And no new classes should be added

#Scenario: Recover From Clicking Cancel
#  Given I am on the "Fall 2011" Create Class Page
#  When I fill in "Course Name" with "Math"
#  And I press "Cancel"
#  Then I should be on the Are You Sure? Page
#  When I press "No"
#  Then I should be on the "Fall 2011" Create Class Page
#  And the "Class Name" field should contain "Math"
  
Scenario: Invalid class min/max
  Given I am on the "Fall 2011" Session Name Page
  And I follow "Add +"
  And I fill in "Min. Class Size" with "20"
  And I fill in "Max. Class Size" with "1"
  And I press "Add New Course"
  Then I should see "Invalid class min value"
  Then I should see "Invalid class max value"
  
Scenario: Invalid course fee
  Given I am on the "Fall 2011" Session Name Page
  And I follow "Add +"
  And I fill in "Price Per Student Per Meeting" with "-10"
  And I press "Add New Course"
  Then I should see "The fee per meeting is invalid"
  
#Scenario: Invalid course start/end time
#  Given I am on the "Fall 2011" Session Name Page
#  And I follow "Add +"
#  And I fill in "Start Hour" with "1.5"
#  And I fill in "End Hour" with "1.5"
#  And I press "Add New Course"
#  Then I should see "Invalid"
