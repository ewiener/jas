Feature: Add class to the session
  
  As an administrator
  So that I can schedule classes for the session
  I want to add classes to the new session
  
Background: populate db with a single class session

  Given the following sessions exist:
  | name        | start_date    | end_date  | lottery_deadline  | registration_deadline | dates_with_no_classes |
  | Fall 2011   | 09/15/2011    | 12/15/2011| 09/09/2011        | 09/14/2011            | 11/13/2011            |

Given the following courses have been added:
    | name    | semester      | description | start_time        | class_min | class_max | grade_range   | fee_per_meeting   | fee_for_additional_materials  | monday    | tuesday   | wednesday | thursday  | friday    | end_time     | sunday | saturday | number_of_classes | total_fee |
    | Artistic Dance     | Fall 2011     | art class   | 2:10pm            | 5         | 15        | K-5           | 10                | 15                            | true      | false       | false     | false     | false     | 3:10pm     | false | false | 12 | 122 |

Scenario: Attempt to delete a course that does not exist

Scenario: Invalid Semester when trying to add a new course
  Given I am on the "Fall 2112" new Course Name Page
  Then I should be on the home page
  And I should see "Error: Unable to find the semester for the course."

Scenario: Edit Course
  Given I am on the "Fall 2011" Session Name Page
  And I press "Edit"
  Then I should be on the "Fall 2011" "Artistic Dance" Course Edit Page
  And I fill in "Start Time" with "6:45pm"
  And I press "Update Course"
  Then I should be on the "Fall 2011" Session Name Page
  And I should see "Artistic Dance in Fall 2011 was successfully updated."
  And I should see "6:45pm"
  
Scenario: Verify index redirects back to that semesters home page
  Given I am on the "Fall 2011" Course Page
  Then I should be on the "Fall 2011" Session Name Page
  
Scenario: Attempt to edit a course not in the database
  Given I am on the "Fall 2011" "Drawing" Course Edit Page
  Then I should be on the "Fall 2011" Session Name Page
  And I should see "Unable to locate the course given for modification."

@javascript
Scenario: Delete a class
  Given I am on the "Fall 2011" Session Name Page
  Then I should see "Artistic Dance"
  When I press "Delete"
  And I confirm popup
  Then I should be on the "Fall 2011" Session Name Page
  And I should see "Artistic Dance was successfully removed"
  And I should not see "3:10pm"

@javascript
Scenario: Cancel delete a class
  Given I am on the "Fall 2011" Session Name Page
  Then I should see "Artistic Dance"
  When I press "Delete"
  And I dismiss popup
  Then I should be on the "Fall 2011" Session Name Page
  And I should not see "Artistic Dance was successfully removed"
  And I should see "3:10pm"
  
@javascript
Scenario: Delete a class
  Given I am on the "Fall 2011" Session Name Page
  Then I should see "Artistic Dance"
  When I press "Edit"
  And I check "course_thursday"
  And I uncheck "course_monday"
  And I press "Update Course"
  Then I should be on the "Fall 2011" Session Name Page
  Then I should see "Th"
  

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
  And I fill in "End Time" with "5:10pm"
  And I fill in "Min. Class Size" with "1"
  And I fill in "Max. Class Size" with "20"
  And I fill in "Eligible Grades" with "1-5"
  And I fill in "Price Per Student Per Meeting" with "10"
  And I fill in "Fee for Additional Materials" with "15"
  And I fill in "Number of Meetings" with "10"
  And I fill in "Total Fee" with "100"
  And I fill in "Eligible Grades" with "1-3"
  And I press "Add New Course"
  Then I should be on the "Fall 2011" Session Name Page
  And I should see "Math"
  
Scenario: Cancel Create New Class
  Given I am on the home page
  And I follow "Fall 2011"
  Then I should be on the "Fall 2011" Session Name Page
  When I follow "Add +"
  Then I should be on the "Fall 2011" Create Class Page
  When I fill in "Course Name" with "Silly Science"
  And I follow "Cancel"
  #Then I should be on the Are You Sure? Page
  #When I press "Yes"
  Then I should be on the "Fall 2011" Session Name Page
  And I should not see "Silly Science"

#Scenario: Recover From Clicking Cancel
#  Given I am on the "Fall 2011" Create Class Page
#  When I fill in "Course Name" with "Math"
#  And I folow "Cancel"
#  Then I should be on the Are You Sure? Page
#  When I press "No"
#  Then I should be on the "Fall 2011" Create Class Page
#  And the "Class Name" field should contain "Math"
  
Scenario: Invalid class min/max
  Given I am on the "Fall 2011" Session Name Page
  And I follow "Add +"
  Then I should be on the "Fall 2011" new Course Name Page 
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
