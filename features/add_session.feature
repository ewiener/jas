Feature: Adding/Editing a session

  As an administrator
  So that I can keep track of classes/PTA Instructors/Students/Parents
  I want to create/edit sessions in the database

Background: previous sessions have been added to the database
  
  Given the following sessions exist:
    | name        | start_date    | end_date  | lottery_deadline  | registration_deadline | dates_with_no_classes | fee |
    | Fall 2011   | 09/15/2011    | 12/15/2011| 09/09/2011        | 09/14/2011            | 11/13/2011            | 35  |
    | Spring 2012 | 02/15/2012    | 06/15/2012| 01/21/2012        | 01/31/2012            | 04/14/2012            | 29  |
    | Fall 2012   | 09/15/2012    | 12/15/2012| 09/09/2012        | 09/14/2012            | 11/13/2012            | 31  |
    
  Given the following pta instructors exist:
  | name    | email     | phone     | address       | bio       | semester  |
  | teacher1| jim@a.com | 4156891212| 12 Cedar Lane | Some info | Spring 2012 |
  | teacher2| amy@a.com | 4156891212| 12 Cedar Lane | Some info | Spring 2012 |
  
  Given the following classrooms are in the database:
  | name    | grade | classroom | semester  |
  | joe     | 1     | room1     | Spring 2012 |
  | joe     | 1     | room2     | Spring 2012 |
  
  Given the following courses have been added:
    | name    | semester      | description | start_time        | class_min | class_max | grade_range   | fee_per_meeting   | fee_for_additional_materials  | monday    | tuesday   | wednesday | thursday  | friday    | end_time     | sunday | saturday | number_of_classes | total_fee | ptainstructor | teacher   |
    | Art     | Spring 2012   | art class   | 2:10pm            | 5         | 15        | K-5           | 10                | 15                            | true      | false       | false     | false     | false     | 3:10pm     | false | false | 12 | 122 | teacher1 | room1 |
    | Science | Spring 2012   | sci class   | 2:15pm            | 10         | 20        | K            | 15                | 5                              | true      | false     | false     | false     | false     | 3:15pm     | false | false | 13 | 133 | teacher2 | room2 |
  
  And I am on the home page

Scenario: Displaying Sessions
  Then I should see "Spring 2012" before "Fall 2011"

Scenario: Create new session
  When I follow "Create New Session"
  Then I am on the Session Name Page
  And I fill in the new session form correctly with name "Fall 2012"
  And I press "Save Semester"
  Then I should be on the home page
  And I should see "Fall 2012"
  And I should see "Spring 2012"
  And I should see "Fall 2011"

##will implement import at a later date  
#Scenario: Import classes from last semester
#  Given I am on the "Fall 2012" Session Name Page
#  When I press "Import"
#  Then I should see "Art"
#  And I should see "Science"
#  When I check "Art"
#  And I check "Science"
#  And I press "Import"
#  Then I should be on the "Fall 2012" Session Name Page
#  And I should see "Art"
#  And I should see "Science"

##will implement import at a later date
#Scenario: Cancel import of classes from last semester
#  Given I am on the "Fall 2012" Session Name Page
#  When I press "Import"
#  Then I should see "Art"
#  And I should see "Science"
#  When I press "Cancel"
#  Then I should be on the "Fall 2012" Session Name Page
#  And I should not see "Science"
#  And I should not see "Art"
  
Scenario: View semester
  And I follow "Spring 2012"
  Then I should be on the "Spring 2012" Session Name Page
  Then I should see "Art"
  And I should see "Science"
  
Scenario: Add a semester with missing necessary fields
  When I follow "Create New Session"
  Then I am on the Session Name Page
  When I fill in "Session Name" with "Fall 2012"
  And I press "Save Semester"
  Then I should be on the Session Name Page
  And I should see "The lottery deadline could not be parsed"
  
Scenario: Access a semester not in the database
  Given I am on the "Fall 1990" Session Name Page
  Then I should be on the home page
  And I should see "Could not find the corresponding semester"
  
Scenario: Entering start date after end date
  When I follow "Create New Session"
  Then I am on the Session Name Page
  And I fill in "Start Date" with "12/15/2012"
  And I fill in "End Date" with "09/21/2012"
  And I press "Save Semester"
  Then I should be on the Session Name Page
  And I should see "Start date must be before end date"
  
Scenario: Entering date with invalid year
  When I follow "Create New Session"
  Then I am on the Session Name Page
  And I fill in "Start Date" with "12/15/2212"
  And I press "Save Semester"
  Then I should be on the Session Name Page
  And I should see "The start date cannot be parsed."

@javascript  
Scenario: Delete semester 
  Given I am on the "Fall 2011" Session Name Page
  And I press "Delete Fall 2011"
  And I confirm popup
  And I wait for 1 seconds
  Then I should be on the home page
  And I should see "Fall 2011 was successfully deleted"

@javascript  
Scenario: Cancel deleted semester
  Given I am on the "Spring 2012" Session Name Page
  And I press "Delete Spring 2012"
  And I dismiss popup
  Then I should be on the "Spring 2012" Session Name Page
  
Scenario: Update registration page
  Given I am on the "Fall 2011" Session Name Page
  Then the "Registration Fee: $" field should contain "35"
  When I fill in "Registration Fee: $" with "100"
  And I press "Update"
  Then I should be on the "Fall 2011" Session Name Page
  And I should see "Fall 2011 was successfully updated."
  And the "Registration Fee: $" field should contain "100"
