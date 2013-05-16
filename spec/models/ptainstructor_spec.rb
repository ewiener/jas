require 'spec_helper'

describe Instructor do
  describe 'Test valid first name of pta instructor' do
    it 'I test first_name_is_valid? with valid name' do
      @instructor = Instructor.new
      @instructor.first_name = "Jane"
      @instructor.first_name_is_valid?.should == true
    end

    it 'I test first_name_is_valid? with invalid name "" ' do
      @instructor = Instructor.new
      @instructor.first_name = ""
      @instructor.first_name_is_valid?.should == false
    end

    it 'I test first_name_is_valid? with invalid name nil' do
      @instructor = Instructor.new
      @instructor.first_name_is_valid?.should == false
    end
  end

  describe 'Test valid last name of pta instructor' do
    it 'I test last_name_is_valid? with valid name' do
      @instructor = Instructor.new
      @instructor.last_name = "Johnson"
      @instructor.last_name_is_valid?.should == true
    end

    it 'I test last_name_is_valid? with valid name "" ' do
      @instructor = Instructor.new
      @instructor.last_name = ""
      @instructor.last_name_is_valid?.should == true
    end

    it 'I test last_name_is_valid? with invalid name nil' do
      @instructor = Instructor.new
      @instructor.last_name_is_valid?.should == false
    end
  end

  describe 'Test valid email of pta instructor' do
    it 'I test email_is_valid? with valid email' do
      @instructor = Instructor.new
      @instructor.email = "john@gmail.com"
      @instructor.email_is_valid?.should == true
    end

    it 'I test email_is_valid? with invalid email "" ' do
      @instructor = Instructor.new
      @instructor.email = ""
      @instructor.email_is_valid?.should == false
    end

    it 'I test email_is_valid? with invalid email nil' do
      @instructor = Instructor.new
      @instructor.email_is_valid?.should == false
    end

    it 'I test email_is_valid? with invalid email john.com' do
      @instructor = Instructor.new
      @instructor.email = "john.com"
      @instructor.email_is_valid?.should == false
    end

    it 'I test email_is_valid? with invalid email john' do
      @instructor = Instructor.new
      @instructor.email = "john"
      @instructor.email_is_valid?.should == false
    end

    it 'I test email_is_valid? with @.com' do
      @instructor = Instructor.new
      @instructor.email = "@.com"
      @instructor.email_is_valid?.should == false
    end
  end

  describe 'Test if phone is valid' do
    it 'I test phone_is_valid? with valid number' do
      @instructor = Instructor.new
      @instructor.phone = "(925) 123-4567"
      @instructor.phone_is_valid?.should == true
    end

    it 'I test phone_is_valid? with valid number without ()' do
      @instructor = Instructor.new
      @instructor.phone = "925-123-4567"
      @instructor.phone_is_valid?.should == true
    end

    it 'I test phone_is_valid? with valid number with no spaces' do
      @instructor = Instructor.new
      @instructor.phone = "9251234567"
      @instructor.phone_is_valid?.should == true
    end

    it 'I test phone_is_valid? with invalid number ---------' do
      @instructor = Instructor.new
      @instructor.phone = "---------"
      @instructor.phone_is_valid?.should == false
    end

    it 'I test phone_is_valid? with invalid number with 1' do
      @instructor = Instructor.new
      @instructor.phone = "1-925-123-4567"
      @instructor.phone_is_valid?.should == false
    end

    it 'I test phone_is_valid? with invalid number with less than 9 digits' do
      @instructor = Instructor.new
      @instructor.phone = "(925) 123-456"
      @instructor.phone_is_valid?.should == false
    end

    it 'I test phone_is_valid? with invalid number with more than 10 digits' do
      @instructor = Instructor.new
      @instructor.phone = "12 (925) 123-4567"
      @instructor.phone_is_valid?.should == false
    end
  end

  describe 'Test valid address' do
    it 'I test address_is_valid? with valid address' do
      @instructor = Instructor.new
      @instructor.address = "700 Main St. SF, CA 94109"
      @instructor.address_is_valid?.should == true
    end

    it 'I test address_is_valid? with invalid address "" ' do
      @instructor = Instructor.new
      @instructor.address = ""
      @instructor.address_is_valid?.should == false
    end

    it 'I test address_is_valid? with invalid address nil' do
      @instructor = Instructor.new
      @instructor.address_is_valid?.should == false
    end
  end
end

