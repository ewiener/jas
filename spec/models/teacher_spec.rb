require 'spec_helper'

describe Teacher do
  describe 'Test if teachers name is valid' do
    it 'I test name_is_valid? with valid name' do
      @teacher = Teacher.new
      @teacher.name = "Jane Smith"
      @teacher.name_is_valid?.should == true
    end

    it 'I test name_is_valid? with valid name J' do
      @teacher = Teacher.new
      @teacher.name = "J"
      @teacher.name_is_valid?.should == true
    end

    it 'I test name_is_valid? with invalid name 13' do
      @teacher = Teacher.new
      @teacher.name = 13
      @teacher.name_is_valid?.should == false
    end

    it 'I test name_is_valid? with invalid name "" ' do
      @teacher = Teacher.new
      @teacher.name = ""
      @teacher.name_is_valid?.should == false
    end

    it 'I test name_is_valid? with nil' do
      @teacher = Teacher.new
      @teacher.name_is_valid?.should == false
    end
  end

  describe 'Test if grade is valid' do
    it 'I test grade_is_valid? with valid name' do
      @teacher = Teacher.new
      @teacher.grade = "5"
      @teacher.grade_is_valid?.should == true
    end

    it 'I test grade_is_valid? with invalid name 3' do
      @teacher = Teacher.new
      @teacher.grade = 3
      @teacher.grade_is_valid?.should == false
    end

    it 'I test grade_is_valid? with invalid name "" ' do
      @teacher = Teacher.new
      @teacher.grade = ""
      @teacher.grade_is_valid?.should == false
    end

    it 'I test grade_is_valid? with invalid nil' do
      @teacher = Teacher.new
      @teacher.grade_is_valid?.should == false
    end
  end

  describe 'Test if classroom is valid' do
    it 'I test classroom_is_valid? with valid classroom' do
      @teacher = Teacher.new
      @teacher.classroom = "203"
      @teacher.classroom_is_valid?.should == true
    end

    it 'I test classroom_is_valid? with valid classroom S' do
      @teacher = Teacher.new
      @teacher.classroom = "S"
      @teacher.classroom_is_valid?.should == true
    end

    it 'I test classroom_is_valid? with invalid classroom 303' do
      @teacher = Teacher.new
      @teacher.classroom = 303
      @teacher.classroom_is_valid?.should == false
    end

    it 'I test classroom_is_valid? with invalid classroom "" ' do
      @teacher = Teacher.new
      @teacher.classroom = ""
      @teacher.classroom_is_valid?.should == false
    end

    it 'I test classroom_is_valid? with invalid classroom nil' do
      @teacher = Teacher.new
      @teacher.classroom_is_valid?.should == false
    end
  end
end
