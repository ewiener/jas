require 'spec_helper'

describe Student do
  describe 'Test if students first name is valid' do
    it 'I test first_name_is_valid? with valid name' do
      @student = Student.new
      @student.first_name = "Joe"
      @student.first_name_is_valid?.should == true
    end

    it 'I test first_name_is_valid? with valid name J' do
      @student = Student.new
      @student.first_name = "J"
      @student.first_name_is_valid?.should == true
    end

    it 'I test first_name_is_valid? with invalid name 13' do
      @student = Student.new
      @student.first_name = 13
      @student.first_name_is_valid?.should == false
    end

    it 'I test first_name_is_valid? with invalid name "" ' do
      @student = Student.new
      @student.first_name = ""
      @student.first_name_is_valid?.should == false
    end

    it 'I test first_name_is_valid? with invalid name nil' do
      @student = Student.new
      @student.first_name_is_valid?.should == false
    end
  end

  describe 'Test if students last name is valid' do
    it 'I test last_name_is_valid? with valid name' do
      @student = Student.new
      @student.last_name = "Joe"
      @student.last_name_is_valid?.should == true
    end

    it 'I test last_name_is_valid? with valid name J' do
      @student = Student.new
      @student.last_name = "J"
      @student.last_name_is_valid?.should == true
    end

    it 'I test last_name_is_valid? with invalid name 13' do
      @student = Student.new
      @student.last_name = 13
      @student.last_name_is_valid?.should == false
    end

    it 'I test last_name_is_valid? with invalid name "" ' do
      @student = Student.new
      @student.last_name = ""
      @student.last_name_is_valid?.should == false
    end

    it 'I test last_name_is_valid? with invalid name nil' do
      @student = Student.new
      @student.last_name_is_valid?.should == false
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

    it 'I test grade_is_valid? with invalid grade nil' do
      @student = Student.new
      @student.grade_is_valid?.should == false
    end

    it 'I test grade_is_valid? with invalid grade 1' do
      @student = Student.new
      @student.grade = 1
      @student.grade_is_valid?.should == false
    end
  end

  describe 'Test valid email of students parents' do
    it 'I test parent_email_is_valid? with valid email' do
      @student = Student.new
      @student.parent_email = "john@gmail.com"
      @student.parent_email_is_valid?.should == true
    end

    it 'I test parent_email_is_valid? with empty email "" ' do
      @student = Student.new
      @student.parent_email = ""
      @student.parent_email_is_valid?.should == true
    end

    it 'I test parent_email_is_valid? with valid value nil' do
      @student = Student.new
      @student.parent_email_is_valid?.should == true
    end

    it 'I test parent_email_is_valid? with invalid email john.com' do
      @student = Student.new
      @student.parent_email = "john.com"
      @student.parent_email_is_valid?.should == false
    end

    it 'I test parent_email_is_valid? with invalid email john' do
      @student = Student.new
      @student.parent_email = "john"
      @student.parent_email_is_valid?.should == false
    end

    it 'I test parent_email_is_valid? with @.com' do
      @student = Student.new
      @student.parent_email = "@.com"
      @student.parent_email_is_valid?.should == false
    end
  end

  describe 'Test if parent phone is valid' do
    it 'I test parent_phone_is_valid? with valid number' do
      @student = Student.new
      @student.parent_phone = "(925) 123-4567"
      @student.parent_phone_is_valid?.should == true
    end

    it 'I test parent_phone_is_valid? with valid number without ()' do
      @student = Student.new
      @student.parent_phone = "925-123-4567"
      @student.parent_phone_is_valid?.should == true
    end

    it 'I test parent_phone_is_valid? with valid number with no spaces' do
      @student = Student.new
      @student.parent_phone = "9251234567"
      @student.parent_phone_is_valid?.should == true
    end

    it 'I test parent_phone_is_valid? with invalid number ---------' do
      @student = Student.new
      @student.parent_phone = "---------"
      @student.parent_phone_is_valid?.should == false
    end

    it 'I test parent_phone_is_valid? with invalid number with 1' do
      @student = Student.new
      @student.parent_phone = "1-925-123-4567"
      @student.parent_phone_is_valid?.should == false
    end

    it 'I test parent_phone_is_valid? with invalid number with less than 9 digits' do
      @student = Student.new
      @student.parent_phone = "(925) 123-456"
      @student.parent_phone_is_valid?.should == false
    end

    it 'I test parent_phone_is_valid? with invalid number with more than 10 digits' do
      @student = Student.new
      @student.parent_phone = "12 (925) 123-4567"
      @student.parent_phone_is_valid?.should == false
    end
  end

end



