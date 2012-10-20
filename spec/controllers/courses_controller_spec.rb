require 'spec_helper'

describe CoursesController do
  describe 'Create a new course' do
    it 'When I go to the "Fall 2012" session page and click "Add New", then I should be on the "Create Class" page' do
    end

    it 'When I fill in "Class Name" with "Music" and I click the dropdown in "PTA Instructor" for "Mary Summers" and I fill in "Class Description" with "A music class that teaches children the fundamentals of music" and I select in the "Days" checkboxes "Monday" and "Wednesday" and I fill in "Start Time" with "3" and "10" and select the dropdown for "PM" and I fill in "End Time" with "5" and "10" and select the dropdown for "PM" and I click the dropdown of "Room" and select "Auditorium" and I fill in "Grades" with "1-5" and I fill in "Min" of "Student Caps" with "0" and "Max" with "15 and I fill in "Price per Meeting" of "Fees" with "12" and I fill in "Number of Meetings" with "15" and I fill "Additional Materials" with "25" and I click "Calculate Total" and I click "Create", it should save the class' do
      end

  end

  describe 'Create a new course without completing all forms' do
    it 'When I fill in "Class Name" with "Music" and I click "Create", it should not save the class'
    end


