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
      @course.start_time_hour_is_valid?.should == true
    end
  end
end
