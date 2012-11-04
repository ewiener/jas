require 'spec_helper'

describe SemestersController do
  describe 'Create a new Session', :type => :request do
    it 'When I go to the home page, and I click on "Create New Session", it should be on the New Session page' do
      Semester.should_receive(:new)
      get "semesters/new"

    end

    it 'And I fill in all the data forms for the new session and I click "Create", it should save the session' do
      Semester.should_receive(:create)#.with({:name => "Fall 2012"},{:start_date => "9/3/2012"}, {:end_date => "10/1/2012"}, {:dates_with_no_classes => "9/17/2012"}, {:lottery_deadline =>"9/23/2012"}, {:registration_deadline => "9/25/2012"})

      post :create, {:semester => {"name"=>"Fall 2012", "start_date"=>"8/15/2012", "end_date"=>"12/21/2012", "registration_deadline"=>"7/30/2012", "lottery_deadline"=>"8/5/2012", "fee"=>"100"}, "commit"=>"Save Semester"}

    end
  end

  describe 'Create a new Session with "Start Date" after "End Date"' do
    it 'I fill in all the data forms for the new session and I input the "Start Date" after the "End Date" and I click "Create", it should not save the session' do

      Semester.should_receive(:create).with({:name => "Fall 2012"},{:start_date => "10/1/2012"}, {:end_date => "9/3/2012"}, {:dates_with_no_classes => "9/17/2012"}, {:lottery_deadline =>"9/23/2012"}, {:registration_deadline => "9/25/2012"}).and_return(nil)

    end
  end

  describe 'Create a new Session with "Days Class Wont Meet" in which the span of days is not possible' do
    it 'I fill in all the data forms for the new session and I input the "Days Class Wont Meet" with date outside span of "Start Date" and "End Date" and I click "Create", it should not save the session' do

      Semester.should_receive(:create).with({:name => "Fall 2012"},{:start_date => "10/1/2012"}, {:end_date => "9/3/2012"}, {:dates_with_no_classes => "9/1/2012"}, {:lottery_deadline =>"9/23/2012"}, {:registration_deadline => "9/25/2012"}).and_return(nil)
    end
  end

  describe 'Create a new Session without "Registration Fee" filled' do
    it 'I fill in all the data forms for the new session except "Registration Fee" and I click "Create", it should not save the session' do

      Semester.should_receive(:create).with({:name => "Fall 2012"},{:start_date => "9/3/2012"}, {:end_date => "10/1/2012"}, {:dates_with_no_classes => "9/17/2012"}, {:lottery_deadline =>"9/23/2012"}).and_return(nil)
    end
  end

  describe 'Create a new Session with beginning of span is after end of span in "Days Wont Meet"' do
    it 'I fill in all the data forms for the new session and I input the "Start Date" after the "End Date" and I click "Create", it should not save the session' do

      Semester.should_receive(:create).with({:name => "Fall 2012"},{:start_date => "10/1/2012"}, {:end_date => "9/3/2012"}, {:lottery_deadline =>"9/23/2012"}, {:registration_deadline => "9/25/2012"}).and_return(nil) #did not include dates_with_no_classes in receive because array

    @semester.dates_with_no_classes do |date|
        if !valid_date date
        errors.add(:dates_with_no_classes,"Invalid Span")
      end
      end
    end
  end
end


