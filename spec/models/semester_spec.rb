require 'spec_helper'

describe Semester do
  describe 'Check if name is valid' do
    it 'I test if proper name is valid and it should be' do
      @semester = Semester.new
      @semester.name = "Mary Lane"
      @semester.name_is_valid?.should == true
    end

    it 'I test if inproper name is valid and it shouldnt be' do
      @semester = Semester.new
      @semester.name = ""
      @semester.name_is_valid?.should == false
    end
  end

  describe 'Check if name_is_valid add errors' do
    it 'I test name_is_valid with invalid name and it should return errors' do
      @semester = Semester.new
      @semester.name = ""
      @semester.errors.should_receive(:add).with({:name => "Invalid empty string for name"})
    end

    it 'I test name_is_valid with valid name and it should not return errors' do
      @semester = Semester.new
      @semester.name = "Mary Lane"
      @semester.errors.should_not_receive(:add).with({:name => "Invalid empty string for name"})
    end
  end

  describe 'Check if valid_start_date adds errors' do
    it 'I test valid_start_date with invalid date and it should return errors' do
      @semester = Semester.new
      @semester.start_date = "10/32/2012"
      @semester.errors.should_receive(:add).with({:start_date => "The start date cannot be parsed"}) #not sure if errors is accessible
    end

    it 'I test valid_start_date with valid date and it should not return errors' do
      @semester = Semester.new
      @semester.start_date = "10/31/2012"
      @semester.errors.should_not_receive(:add).with({:start_date => "The start date cannot be parsed"})
    end
  end

  describe 'Check if start date is valid' do
    it 'I test if valid start date is valid and it should be' do
      @semester = Semester.new
      @semester.start_date = "10/12/2012"
      @semester.start_date_is_valid?.should == true
    end

    it 'I test if invalid start date is valid and it should not be' do
      @semester = Semester.new
      @semester.start_date = "10/32/2012"
      @semester.start_date_is_valid?.should == false
    end
  end

  describe 'Check if end date is valid' do
    it 'I test if valid end date is valid and it should be' do
      @semester = Semester.new
      @semester.end_date = "10/12/2012"
      @semester.end_date_is_valid?.should == true
    end

    it 'I test if invalid end date is valid and it should not be' do
      @semester = Semester.new
      @semester.end_date = "10/32/2012"
      @semester.end_date_is_valid?.should == false
    end
  end

  describe 'Check if valid_end_date adds errors' do
    it 'I test valid_end_date with invalid date and it should return errors' do
      @semester = Semester.new
      @semester.end_date = "10/32/2012"
      @semester.errors.should_receive(:add).with({:end_date => "The end date cannot be parsed"})
    end

    it 'I test valid_end_date with valid date and it should not return errors' do
      @semester = Semester.new
      @semester.end_date = "10/31/2012"
      @semester.errors.should_not_receive(:add).with({:end_date => "The end date cannot be parsed"})
    end
  end

  describe 'Check if registration deadline is valid' do
    it 'I test if valid registration deadline is valid and it should be' do
      @semester = Semester.new
      @semester.registration_deadline = "10/20/2012"
      @semester.registration_date_is_valid.should == true
    end

    it 'I test if invalid registration deadline is valid and it should not be' do
      @semester = Semester.new
      @semester.registration_deadline = "10/32/2012"
      @semester.registration_date_is_valid.should == false
    end
  end

  describe 'Check if valid_registration_date adds errors' do
    it 'I test if valid_registration_date with invalid registration deadline and it should add errors' do
      @semester = Semester.new
      @semester.registration_deadline = "10/32/2012"
      @semester.errors.should_receive(:add).with({:registration_deadline => "The registration deadline could not be parsed."})
    end

    it 'I test if valid_registration_date with valid registration deadline and it should not add errors' do
      @semester = Semester.new
      @semester.registration_deadline = "10/31/2012"
      @semester.errors.should_not_receive(:add).with({:registration_deadline => "The registration deadline could not be parsed"})
    end
  end

  describe 'Check if valid_lottery_date adds errors' do
    it 'I test if valid_lottery_date with invalid date and it should add errors' do
      @semester = Semester.new
      @semester.lottery_deadline = "9/32/2012"
      @semester.errors.should_receive (:add).with({:lottery_deadline => "The lottery deadline could not be parsed"})
      end

    it 'I test if valid_lottery_date with valid date and it should not add errors' do
      @semester = Semester.new
      @semester.lottery_deadline = "9/30/2012"
      @semester.errors.should_not_receive (:add).with({:lottery_deadline => "The lottery deadline could not be parsed"}) #needs to deal with create
    end
  end
end




