require 'spec_helper'

describe Course do
  describe 'Test if the number of classes is valid' do
    it 'I test number_of_classes_is_valid? with valid number' do
      @course = Course.new
      @course.number_of_classes = 10
      @course.number_of_classes_is_valid?.should == true
    end

    it 'I test number_of_classes_is_valid? with invalid number' do
      @course = Course.new
      @course.number_of_classes = -1
      @course.number_of_classes_is_valid?.should == false
    end
  end

  describe 'Test if the start time is valid' do
    it 'I test start_time_hour_is_valid? with valid hour' do
      @course = Course.new
      @course.start_time_hour = 3
      @course.start_time_type = 1
      @course.start_time_hour_is_valid?.should == true
    end

    it 'I test start_time_hour_is_valid? with invalid hour' do
      @course = Course.new
      @course.start_time_hour = 13
      @course.start_time_type = 1
      @course.start_time_hour_is_valid?.should == false
    end
  end

  describe 'Test if start time minute is valid' do
    it 'I test start_time_minute_is_valid? with valid minute' do
      @course = Course.new
      @course.start_time_minute = 10
      @course.start_time_type = 1
      @course.start_time_minute_is_valid?.should == true
    end

    it 'I test start_time_minute_is_valid? with invalid minute' do
      @course = Course.new
      @course.start_time_minute = 60
      @course.start_time_type = 1
      @course.start_time_minute_is_valid?.should == false
    end
  end

  describe 'Test if end time hour is valid' do
    it 'I test end_time_hour_is_valid? with valid hour' do
      @course = Course.new
      @course.end_time_hour = 5
      @course.end_time_type = 1
      @course.end_time_hour_is_valid?.should == true
    end

    it 'I test end_time_hour_is_valid? with invalid hour' do
      @course = Course.new
      @course.end_time_hour = 13
      @course.end_time_type = 1
      @course.end_time_hour_is_valid?.should == false
    end
  end

  describe 'Test if end time minute is valid' do
    it 'I test end_time_minute_is_valid? with valid minute' do
      @course = Course.new
      @course.end_time_minute = 10
      @course.end_time_type = 1
      @course.end_time_minute_is_valid?.should == true
    end

    it 'I test end_time_minute_is_valid? with invalid minute' do
      @course = Course.new
      @course.end_time_minute = 60
      @course.end_time_type = 1
      @course.end_time_minute_is_valid?.should == false
    end
  end

  describe 'Test if days of week are valid' do
    it 'I test days_of_week_are_valid? with valid days' do
      @course = Course.new
      @course.update_attributes(:sunday => false, :monday => true, :tuesday => false, :wednesday => true, :thursday => false, :friday => false, :saturday => false)
      @course.days_of_week_are_valid?.should == true
    end

    it 'I test days_of_week_are_valid? without any days' do
      @course = Course.new
      @course.days_of_week_are_valid?.should == false
    end
  end

  describe 'Test comparing class min and class max' do
    it 'I test class_min_is_valid? with larger class_min than class_max' do
      @course = Course.new
      @course.class_min = 5
      @course.class_max = 2
      @course.class_min_is_valid?.should == false
    end

    it 'I test class_max_is_valid? with larger class_min than class_max' do
      @course = Course.new
      @course.class_min = 5
      @course.class_max = 2
      @course.class_max_is_valid?.should == false
    end

    it 'I test class_min_is_valid? and class_max_is_valid? with larger class_max than class_min' do
      @course = Course.new
      @course.class_min = 2
      @course.class_max = 5
      @course.class_min_is_valid?.should == true
      @course.class_max_is_valid?.should == true
    end
  end
end
