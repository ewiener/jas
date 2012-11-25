Feature: Adding PTA instructors to the database

  As an administrator
  So that I can create rosters for the PTA instructors and schedule the PTA instructors
  I want to add PTA instructors to the database
  
Background:

  Given the following sessions exist:
    | name        | start_date    | end_date  | lottery_deadline  | registration_deadline | fee |
    | Fall 2011   | 09/15/2011    | 12/15/2011| 09/09/2011        | 09/14/2011            | 35  |
    
  Given the following pta instructors exist:
  | name    | email     | phone     | address       | bio       | semester  |
  | Jim     | jim@a.com | 4156891212| 12 Cedar Lane | Some info | Fall 2011 |
  | Amy     | amy@a.com | 4156891212| 12 Cedar Lane | Some info | Fall 2011 |
  | Mia     | mia@a.com | 4156891212| 12 Cedar Lane | Some info | Fall 2011 |

Scenario: Create invalid pta instructor
  Given I am on the "Fall 2011" PTA Instructor home page
  And I follow "Add New PTA Instructor"
  Then I should be on the "Fall 2011" Add New PTA Teacher Page
  And press "Add New PTA Instructor"
  Then I should be on the "Fall 2011" Add New PTA Teacher Page
  And I should see "Invalid string for name."
  
Scenario: Update pta instructor invalidly
  Given I am on the "Fall 2011" PTA Instructor home page
  And I follow "Edit"
  #Given I am on the "Fall 2011" "Amy" PTA Instructor Edit Page
  And I fill in "ptainstructor_name" with ""
  And I press "Update PTA Instructor"
  #Then I should be on the "Fall 2011" "Amy" PTA Instructor Edit Page
  And I should see "Invalid string for name."

Scenario: Invalid pta instructor to edit
  Given I am on the "Fall 2011" "dhfhhg" PTA Instructor Edit Page
  Then I should be on the "Fall 2011" PTA Instructor home page
  And I should see "Could not find the corresponding PTA instructor."

Scenario: Invalid semester
  Given I am on the "Fall 2111" PTA Instructor home page
  Then I should be on the home page
  And I should see "Unable to locate the specified semester."

Scenario: Edit PTA Instructor
  Given I am on the "Fall 2011" PTA Instructor home page
  And I follow "Edit"
  And I fill in "Name" with "Mary"
  And I press "Update"
  Then I should be on the "Fall 2011" PTA Instructor home page
  And I should see "information was successfully updated."
  
Scenario: Delete PTA Instructor
  Given I am on the "Fall 2011" PTA Instructor home page
  And I press "Delete"
  Then I should be on the "Fall 2011" PTA Instructor home page
  And I should see "successfully deleted."

Scenario: Creating from the PTA Instructor home page
  Given I am on the "Fall 2011" PTA Instructor home page
  And I follow "Add New PTA Instructor"
  Then I should be on the "Fall 2011" Add New PTA Teacher Page
  When I fill in the new pta form correctly with name "Michelle"
  And press "Add New PTA Instructor"
  Then I should be on the "Fall 2011" PTA Instructor home page
  And I should see "Michelle"
  
Scenario: Creating from the create class page
  Given I am on the "Fall 2011" Create Class Page
  ###Implementing later
  #And I follow "Add New PTA Instructor"
  #Then I should be on the "Fall 2011" Add New PTA Teacher Page
  #When I fill in the new pta form correctly with name "Nancy"
  #And press "Add New PTA Instructor"
  #Then I should be on the "Fall 2011" Create Class Page
  #And I should see "Nancy"
  
Scenario: Cancel creating from the PTA Instructor home page
  Given I am on the "Fall 2011" PTA Instructor home page
  And I follow "Add New PTA Instructor"
  Then I should be on the "Fall 2011" Add New PTA Teacher Page
  When I fill in the new pta form correctly with name "Greg"
  And follow "Cancel"
  Then I should be on the "Fall 2011" PTA Instructor home page
  And I should not see "Greg"
  
Scenario: Cancel creating from the create class page
  Given I am on the "Fall 2011" Create Class Page
  ###Implementing later
  #And I follow "Add New PTA Instructor"
  #Then I should be on the "Fall 2011" Add New PTA Teacher Page
  #When I fill in the new pta form correctly with name "Joe"
  #And follow "Cancel"
  #Then I should be on the "Fall 2011" Create Class Page
  #And I should not see "Joe"
