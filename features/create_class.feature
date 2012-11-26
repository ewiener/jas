Feature: Add class to the session
  
  As an administrator
  So that I can schedule classes for the session
  I want to add classes to the new session
  
Background: populate db with a single class session

  Given the following sessions exist:
  | name        | start_date    | end_date  | lottery_deadline  | registration_deadline |
  | Fall 2011   | 09/15/2011    | 12/15/2011| 09/09/2011        | 09/14/2011            |

  Given the following pta instructors exist:
  | name    | email     | phone     | address       | bio       | semester  |
  | teacher3| jim@a.com | 4156891212| 12 Cedar Lane | Some info | Fall 2011 |
  
  Given the following classrooms are in the database:
  | name    | grade | classroom | semester  |
  | joe     | 1     | room3     | Fall 2011 |

  Given the following courses have been added:
    | name    | semester      | description | start_time        | class_min | class_max | grade_range   | fee_per_meeting   | fee_for_additional_materials  | monday    | tuesday   | wednesday | thursday  | friday    | end_time     | sunday | saturday | number_of_classes | total_fee | ptainstructor | teacher   |
    | Artistic Dance     | Fall 2011     | art class   | 2:10pm            | 5         | 15        | K-5           | 10                | 15                            | true      | false       | false     | false     | false     | 3:10pm     | false | false | 12 | 122 | teacher3 | room3 |
    
  And I am on the home page
  And I follow "Fall 2011"

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
  Given I am on the "Fall 2011" Session Name Page
  When I follow "Add +"
  Then I should be on the "Fall 2011" Create Class Page
  And I fill in the new create class form correctly with subject "Math"
  And I press "Add New Course"
  Then I should be on the "Fall 2011" Session Name Page
  And I should see "Math"
  
Scenario: Create New Invalid Class
  Given I am on the "Fall 2011" Session Name Page
  When I follow "Add +"
  Then I should be on the "Fall 2011" Create Class Page
  And I press "Add New Course"
  Then I should be on the "Fall 2011" Create Class Page
  
Scenario: Cancel Create New Class
  Given I am on the "Fall 2011" Session Name Page
  When I follow "Add +"
  Then I should be on the "Fall 2011" Create Class Page
  When I fill in "Course Name" with "Silly Science"
  And I follow "Cancel"
  Then I should be on the "Fall 2011" Session Name Page
  And I should not see "Silly Science"
  
Scenario: Attemt to create a create a course in an invalid semester
  Given I am on the "Fall 2111" Create Class Page
  Then I should be on the home page
  And I should see "Error: Unable to find the semester for the course."
  
Scenario: Attempt to access an Session Name Page of an invalid year
