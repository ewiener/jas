require 'spec_helper'

describe Classroom do
  describe 'Test if classrooms name is valid' do
    it 'I test name_is_valid? with valid name' do
      @classroom = Classroom.new
      @classroom.teacher = "Jane Smith"
      @classroom.teacher_is_valid?.should == true
    end

    it 'I test name_is_valid? with valid name J' do
      @classroom = Classroom.new
      @classroom.teacher = "J"
      @classroom.teacher_is_valid?.should == true
    end

    it 'I test name_is_valid? with invalid name 13' do
      @classroom = Classroom.new
      @classroom.teacher = 13
      @classroom.teacher_is_valid?.should == false
    end

    it 'I test name_is_valid? with invalid name "" ' do
      @classroom = Classroom.new
      @classroom.teacher = ""
      @classroom.teacher_is_valid?.should == false
    end

    it 'I test name_is_valid? with nil' do
      @classroom = Classroom.new
      @classroom.teacher_is_valid?.should == false
    end
  end

  describe 'Test if grade is valid' do
    it 'I test grade_is_valid? with valid name' do
      @classroom = Classroom.new
      @classroom.grade = "5"
      @classroom.grade_is_valid?.should == true
    end

    it 'I test grade_is_valid? with invalid name 3' do
      @classroom = Classroom.new
      @classroom.grade = 3
      @classroom.grade_is_valid?.should == false
    end

    it 'I test grade_is_valid? with invalid name "" ' do
      @classroom = Classroom.new
      @classroom.grade = ""
      @classroom.grade_is_valid?.should == false
    end

    it 'I test grade_is_valid? with invalid nil' do
      @classroom = Classroom.new
      @classroom.grade_is_valid?.should == false
    end
  end

  describe 'Test if classroom is valid' do
    it 'I test classroom_is_valid? with valid classroom' do
      @classroom = Classroom.new
      @classroom.name = "203"
      @classroom.name_is_valid?.should == true
    end

    it 'I test classroom_is_valid? with valid classroom S' do
      @classroom = Classroom.new
      @classroom.name = "S"
      @classroom.name_is_valid?.should == true
    end

    it 'I test classroom_is_valid? with invalid classroom 303' do
      @classroom = Classroom.new
      @classroom.name = 303
      @classroom.name_is_valid?.should == false
    end

    it 'I test classroom_is_valid? with invalid classroom "" ' do
      @classroom = Classroom.new
      @classroom.name = ""
      @classroom.name_is_valid?.should == false
    end

    it 'I test classroom_is_valid? with invalid classroom nil' do
      @classroom = Classroom.new
      @classroom.name_is_valid?.should == false
    end
  end


  describe 'Test if classroom can be deleted' do
    it 'I test can_be_deleted with classroom who isnt teaching classes this semester' do

      @classroom = Classroom.new
      @classroom.can_be_deleted?.should == true
    end
  end

end
