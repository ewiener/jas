require 'spec_helper'

describe Student do
  describe 'Test if students name is valid' do
    it 'I test name_is_valid? with valid name' do
      @student = Student.new
      @student.name = "Joe Smith"
      @student.name_is_valid?.should == true
    end

    it 'I test name_is_valid? with valid name J' do
      @student = Student.new
      @student.name = "J"
      @student.name_is_valid?.should == true
    end

    it 'I test name_is_valid? with invalid name 13' do
      @student = Student.new
      @student.name = 13
      @student.name_is_valid?.should == false
    end

    it 'I test name_is_valid? with invalid name "" ' do
      @student = Student.new
      @student.name = ""
      @student.name_is_valid?.should == false
    end

    it 'I test name_is_valid? with invalid name nil' do
      @student = Student.new
      @student.name_is_valid?.should == false
    end
  end

  describe 'Test if student has valid grade' do
    it 'I test grade_is_valid? with valid grade' do
      @student = Student.new
      @student.grade = "5"
      @student.grade_is_valid?.should == true
    end

    it 'I test grade_is_valid? with valid grade "K" ' do
      @student = Student.new
      @student.grade = "K"
      @student.grade_is_valid?.should == true
    end

    it 'I test grade_is_valid? with invalid grade "S" ' do
      @student = Student.new
      @student.grade = "S"
      @student.grade_is_valid?.should == false
    end

    it 'I test grade_is_valid? with invalid grade "-1" ' do
      @student = Student.new
      @student.grade = "-1"
      @student.grade_is_valid?.should == false
    end
  end

  describe 'Test valid email of students parents' do
    it 'I test email_is_valid? with valid email' do
      @student = Student.new
      @student.email = "john@gmail.com"
      @student.email_is_valid?.should == true
    end

    it 'I test email_is_valid? with invalid email "" ' do
      @student = Student.new
      @student.email = ""
      @student.email_is_valid?.should == false
    end

    it 'I test email_is_valid? with invalid email nil' do
      @student = Student.new
      @student.email_is_valid?.should == false
    end

    it 'I test email_is_valid? with invalid email john.com' do
      @student = Student.new
      @student.email = "john.com"
      @student.email_is_valid?.should == false
    end

    it 'I test email_is_valid? with invalid email john' do
      @student = Student.new
      @student.email = "john"
      @student.email_is_valid?.should == false
    end

    it 'I test email_is_valid? with @.com' do
      @student = Student.new
      @student.email = "@.com"
      @student.email_is_valid?.should == false
    end
  end

  describe 'Test if phone is valid' do
    it 'I test phone_is_valid? with valid number' do
      @student = Student.new
      @student.phone = "(925) 123-4567"
      @student.phone_is_valid?.should == true
    end

    it 'I test phone_is_valid? with valid number without ()' do
      @student = Student.new
      @student.phone = "925-123-4567"
      @student.phone_is_valid?.should == true
    end

    it 'I test phone_is_valid? with valid number with no spaces' do
      @student = Student.new
      @student.phone = "9251234567"
      @student.phone_is_valid?.should == true
    end

    it 'I test phone_is_valid? with invalid number ---------' do
      @student = Student.new
      @student.phone = "---------"
      @student.phone_is_valid?.should == false
    end

    it 'I test phone_is_valid? with invalid number with 1' do
      @student = Student.new
      @student.phone = "1-925-123-4567"
      @student.phone_is_valid?.should == false
    end

    it 'I test phone_is_valid? with invalid number with less than 9 digits' do
      @student = Student.new
      @student.phone = "(925) 123-456"
      @student.phone_is_valid?.should == false
    end

    it 'I test phone_is_valid? with invalid number with more than 10 digits' do
      @student = Student.new
      @student.phone = "12 (925) 123-4567"
      @student.phone_is_valid?.should == false
    end
  end

end



