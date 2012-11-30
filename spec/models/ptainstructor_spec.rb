require 'spec_helper'

describe Ptainstructor do
  describe 'Test valid first name of pta instructor' do
    it 'I test first_name_is_valid? with valid name' do
      @ptainstructor = Ptainstructor.new
      @ptainstructor.first_name = "Jane"
      @ptainstructor.first_name_is_valid?.should == true
    end

    it 'I test first_name_is_valid? with invalid name "" ' do
      @ptainstructor = Ptainstructor.new
      @ptainstructor.first_name = ""
      @ptainstructor.first_name_is_valid?.should == false
    end

    it 'I test first_name_is_valid? with invalid name nil' do
      @ptainstructor = Ptainstructor.new
      @ptainstructor.first_name_is_valid?.should == false
    end
  end

  describe 'Test valid last name of pta instructor' do
    it 'I test last_name_is_valid? with valid name' do
      @ptainstructor = Ptainstructor.new
      @ptainstructor.last_name = "Johnson"
      @ptainstructor.last_name_is_valid?.should == true
    end

    it 'I test last_name_is_valid? with invalid name "" ' do
      @ptainstructor = Ptainstructor.new
      @ptainstructor.last_name = ""
      @ptainstructor.last_name_is_valid?.should == false
    end

    it 'I test last_name_is_valid? with invalid name nil' do
      @ptainstructor = Ptainstructor.new
      @ptainstructor.last_name_is_valid?.should == false
    end
  end

  describe 'Test valid email of pta instructor' do
    it 'I test email_is_valid? with valid email' do
      @ptainstructor = Ptainstructor.new
      @ptainstructor.email = "john@gmail.com"
      @ptainstructor.email_is_valid?.should == true
    end

    it 'I test email_is_valid? with invalid email "" ' do
      @ptainstructor = Ptainstructor.new
      @ptainstructor.email = ""
      @ptainstructor.email_is_valid?.should == false
    end

    it 'I test email_is_valid? with invalid email nil' do
      @ptainstructor = Ptainstructor.new
      @ptainstructor.email_is_valid?.should == false
    end
=begin
    it 'I test email_is_valid? with invalid email john@gmail' do
      @ptainstructor = Ptainstructor.new
      @ptainstructor.email = "john@gmail"
      @ptainstructor.email_is_valid?.should == false
    end
=end
    it 'I test email_is_valid? with invalid email john.com' do
      @ptainstructor = Ptainstructor.new
      @ptainstructor.email = "john.com"
      @ptainstructor.email_is_valid?.should == false
    end

    it 'I test email_is_valid? with invalid email john' do
      @ptainstructor = Ptainstructor.new
      @ptainstructor.email = "john"
      @ptainstructor.email_is_valid?.should == false
    end

    it 'I test email_is_valid? with @.com' do
      @ptainstructor = Ptainstructor.new
      @ptainstructor.email = "@.com"
      @ptainstructor.email_is_valid?.should == false
    end
  end

  describe 'Test if phone is valid' do
    it 'I test phone_is_valid? with valid number' do
      @ptainstructor = Ptainstructor.new
      @ptainstructor.phone = "(925) 123-4567"
      @ptainstructor.phone_is_valid?.should == true
    end

    it 'I test phone_is_valid? with valid number without ()' do
      @ptainstructor = Ptainstructor.new
      @ptainstructor.phone = "925-123-4567"
      @ptainstructor.phone_is_valid?.should == true
    end

    it 'I test phone_is_valid? with valid number with no spaces' do
      @ptainstructor = Ptainstructor.new
      @ptainstructor.phone = "9251234567"
      @ptainstructor.phone_is_valid?.should == true
    end

    it 'I test phone_is_valid? with invalid number ---------' do
      @ptainstructor = Ptainstructor.new
      @ptainstructor.phone = "---------"
      @ptainstructor.phone_is_valid?.should == false
    end

    it 'I test phone_is_valid? with invalid number with 1' do
      @ptainstructor = Ptainstructor.new
      @ptainstructor.phone = "1-925-123-4567"
      @ptainstructor.phone_is_valid?.should == false
    end

    it 'I test phone_is_valid? with invalid number with less than 9 digits' do
      @ptainstructor = Ptainstructor.new
      @ptainstructor.phone = "(925) 123-456"
      @ptainstructor.phone_is_valid?.should == false
    end

    it 'I test phone_is_valid? with invalid number with more than 10 digits' do
      @ptainstructor = Ptainstructor.new
      @ptainstructor.phone = "12 (925) 123-4567"
      @ptainstructor.phone_is_valid?.should == false
    end
  end

  describe 'Test valid address' do
    it 'I test address_is_valid? with valid address' do
      @ptainstructor = Ptainstructor.new
      @ptainstructor.address = "700 Main St. SF, CA 94109"
      @ptainstructor.address_is_valid?.should == true
    end

    it 'I test address_is_valid? with invalid address "" ' do
      @ptainstructor = Ptainstructor.new
      @ptainstructor.address = ""
      @ptainstructor.address_is_valid?.should == false
    end

    it 'I test address_is_valid? with invalid address nil' do
      @ptainstructor = Ptainstructor.new
      @ptainstructor.address_is_valid?.should == false
    end
  end
end

