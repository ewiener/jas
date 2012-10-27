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
