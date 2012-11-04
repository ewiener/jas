require 'spec_helper'

=begin
describe CoursesController do
  describe 'Create a new course' do
    it 'When I go to the "Fall 2012" session page and click "Add New", then I should be on the "Create Class" page' do
      mock = mock('Course')
      Course.should_receive(:new)
      put :new,
      #Course.should_receive(:new)
      # @course = Course.new
    end

    it 'When I fill in the course information and I fill in the table and I click "Create", it should save the class' do
      mock = mock ('Course')
      mock.stub!(:name)
      mock.stub!(:description)
      mock.stub!(:days_of_week)
      mock.stub!(:number_of_classes)
      mock.stub!(:start_time)
      mock.stub!(:end_time)
      mock.stub!(:class_min)
      mock.stub!(:class_max)
      mock.stub!(:grade_range)
      mock.stub!(:fee_per_meeting)
      mock.stub!(:fee_for_additional_materials)
      Course.should_receive(:create).with({:name => "Music"}, {:description => "A music class that teaches children the fundamentals of music"}, {:days_of_week => "Monday, Wednesday"}, {:number_of_classes => 15}, {:start_time => "3:00"}, {:end_time => "5:00"}, {:class_min => 0}, {:class_max => 15}, {:grade_range => 1-5}, {:fee_per_meeting => 12}, {:fee_for_additional_materials => 25}).and_return(mock)
      post :create, :name => "Music"
      response.should be_success

=begin      @course.name.should == "Music"
      @course.description.should == "A music class that teaches children the fundamentals of music"
      @course.days_of_week.should == "Monday, Wednesday"
      @course.number_of_classes.should == 15
      @course.start_time_hour.should == 3
      @course.start_time_minute.should == 10
      @course.start_time_type.should == "PM"
      @course.end_time_hour.should == 5
      @course.end_time_minute.should == 10
      @course.end_time_type.should == "PM"
      @course.class_min.should == 0
      @course.class_max.should == 15
      @course.grade_range.should == "1-5"
      @course.fee_per_meeting.should == 12
      @course.fee_for_additional_materials.should == 25
    end
=end
    end
  end

  describe 'Create a new course without completing all forms' do
    it 'When I fill in "Class Name" with "Music" and I click "Create", it should not save the class' do
      Course.should_receive(:create).with(:name => "Music").and_return(nil)
    end
  end

  describe 'Create a new course with "Start Time" after "End Time"' do
    it 'When I fill in the course information and fill out "Start Time" after "End Time" and I click "Create", it should not save the class' do
      Course.should_receive(:create).with({:name => "Music"}, {:description => "A music class that teaches children the fundamentals of music"}, {:days_of_week => "Monday, Wednesday"}, {:number_of_classes => 15}, {:start_time_hour => 3}, {:start_time_minute => 10}, {:start_time_type => "PM"}, {:end_time_hour => 5}, {:end_time_minute => 10}, {:end_time_type => "AM"}, {:class_min => 0}, {:class_max => 15}, {:grade_range => 1-5}, {:fee_per_meeting => 12}, {:fee_for_additional_materials => 25}).and_return(nil)
    end
  end

  describe 'Create a new course with "Min" that is greater than "Max"' do
    it 'When I fill in the course information and fill out "Min" greater than "Max" for "Student Caps" and I click "Create", it should not save the class' do
      Course.should_receive(:create).with({:name => "Music"}, {:description => "A music class that teaches children the fundamentals of music"}, {:days_of_week => "Monday, Wednesday"}, {:number_of_classes => 15}, {:start_time_hour => 3}, {:start_time_minute => 10}, {:start_time_type => PM}, {:end_time_hour => 5}, {:end_time_minute => 10}, {:end_time_type => "PM"}, {:class_min => 15}, {:class_max => 0}, {:grade_range => 1-5}, {:fee_per_meeting => 12}, {:fee_for_additional_materials => 25}).and_return(nil)
    end

  end

  describe 'Create a new course with no selected "Day" checkboxes' do
    it 'When I fill in the course information wihout filling in the "Day" checkboxes and I click "Create", it should not save the class' do
      Course.should_receive(:create).with({:name => "Music"}, {:description => "A music class that teaches children the fundamentals of music"}, {:number_of_classes => 15}, {:start_time_hour => 3}, {:start_time_minute => 10}, {:start_time_type => "PM"}, {:end_time_hour => 5}, {:end_time_minute => 10}, {:end_time_type => "PM"}, {:class_min => 0}, {:class_max => 15}, {:grade_range => 1-5}, {:fee_per_meeting => 12}, {:fee_for_additional_materials => 25}).and_return(nil)
    end

  end

  describe 'Create a new course with incorrect "Grades"' do
    it 'When I fill in the course information with incorrect "Grades" I click "Create", it should not save the class' do
      Course.should_receive(:create).with({:name => "Music"}, {:description => "A music class that teaches children the fundamentals of music"}, {:days_of_week => "Monday, Wednesday"}, {:number_of_classes => 15}, {:start_time_hour => 3}, {:start_time_minute => 10}, {:start_time_type => "PM"}, {:end_time_hour => 5}, {:end_time_minute => 10}, {:end_time_type => "PM"}, {:class_min => 0}, {:class_max => 15}, {:grade_range => "0-5"}, {:fee_per_meeting => 12}, {:fee_for_additional_materials => 25}).and_return(nil)
    end

  end

  describe 'Create a new course with difficult-to-parse "Grades"' do
    it 'When I fill in the course information and I fill in "Grades" "K-5" and  I click "Create", it should save the class' do
      Course.should_receive(:create).with({:name => "Music"}, {:description => "A music class that teaches children the fundamentals of music"}, {:days_of_week => "Monday, Wednesday"}, {:number_of_classes => 15}, {:start_time_hour => 3}, {:start_time_minute => 10}, {:start_time_type => "PM"}, {:end_time_hour => 5}, {:end_time_minute => 10}, {:end_time_type => "PM"}, {:class_min => 0}, {:class_max => 15}, {:grade_range => "K-5"}, {:fee_per_meeting => 12}, {:fee_for_additional_materials => 25})

      @course = Course.new
      @course.name.should == "Music"
      @course.description.should == "A music class that teaches children the fundamentals of music"
      @course.days_of_week.should == "Monday, Wednesday"
      @course.number_of_classes.should == 15
      @course.start_time_hour.should == 3
      @course.start_time_minute.should == 10
      @course.start_time_type.should == "PM"
      @course.end_time_hour.should == 5
      @course.end_time_minute.should == 10
      @course.end_time_type.should == "PM"
      @course.class_min.should == 0
      @course.class_max.should == 15
      @course.grade_range.should == "K-5"
      @course.fee_per_meeting.should == 12
      @course.fee_for_additional_materials.should == 25
    end
  end

    describe 'Create a class with invalid values for "Number of Class Meetings"' do
      it 'When I create a new class with invalid values for "Number of Class Meetings" and I click "Create", it should not save the class' do
        Course.should_receive(:create).with({:name => "Music"}, {:description => "A music class that teaches children the fundamentals of music"}, {:days_of_week => "Monday, Wednesday"}, {:number_of_classes => -5}, {:start_time_hour => 3}, {:start_time_minute => 10}, {:start_time_type => "PM"}, {:end_time_hour => 5}, {:end_time_minute => 10}, {:end_time_type => "PM"}, {:class_min => 0}, {:class_max => 15}, {:grade_range => "1-5"}, {:fee_per_meeting => 12}, {:fee_for_additional_materials => 25}).and_return(nil)
    end
  end

end

=end
