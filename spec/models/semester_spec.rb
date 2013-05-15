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

    it 'I test name_is_invalid? with invalid name nil' do
      @semester = Semester.new
      @semester.name_is_valid?.should == false
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

    it 'I test start_date_is_valid? with invalid date nil' do
      @semester = Semester.new
      @semester.start_date_is_valid?.should == false
    end

    it 'I test start_date_is_valid? with invalid date -1/12/2012' do
      @semester = Semester.new
      @semester.start_date = "-1/12/2012"
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

    it 'I test end_date_is_valid? with invalid date nil' do
      @semester = Semester.new
      @semester.end_date_is_valid?.should == false
    end

    it 'I test end_date_is_valid? with invalid date -1/21/2012' do
      @semester = Semester.new
      @semester.end_date = "-1/21/2012"
      @semester.end_date_is_valid?.should == false
    end
  end

  describe 'Check if registration deadline is valid' do
    it 'I test if valid registration deadline is valid and it should be' do
      @semester = Semester.new
      @semester.registration_deadline = "10/20/2012"
      @semester.registration_date_is_valid?.should == true
    end

    it 'I test if invalid registration deadline is valid and it should not be' do
      @semester = Semester.new
      @semester.registration_deadline = "10/32/2012"
      @semester.registration_date_is_valid?.should == false
    end

    it 'I test registration_date_is_valid? with invalid date -1/21/2012' do
      @semester = Semester.new
      @semester.registration_deadline = "-1/21/2012"
      @semester.registration_date_is_valid?.should == false
    end

    it 'I test registration_date_is_valid? with nil date' do
      @semester = Semester.new
      @semester.registration_date_is_valid?.should == false
    end
  end


  describe 'Check if course can be created' do
    it 'I test can_create_course? when ptainstructor and teacher exist' do
      @semester = Semester.new
      @semester.id = 2
      @semester.name = "Fall 2012"
      @semester.start_date = "08/22/12"
      @semester.end_date = "12/24/12"
      @semester.dates_with_no_classes = []
      @semester.lottery_deadline = "01/22/2012"
      @semester.registration_deadline = "01/22/12"
      @semester.fee = 200
      @semester.save
      @ptainstructor = Ptainstructor.new
      @ptainstructor.id = 2
      @ptainstructor.first_name = "Mary"
      @ptainstructor.last_name = "Katherine"
      @ptainstructor.email = "mary@gmail.com"
      @ptainstructor.phone = "925-987-1234"
      @ptainstructor.address = "1000 Main St. SF, CA 94109"
      @ptainstructor.bio = "I love math"
      @ptainstructor.semester_id = 2
      @ptainstructor.save
      @teacher = Teacher.new
      @teacher.id = 3
      @teacher.name = "Jane"
      @teacher.grade = "2"
      @teacher.classroom = "Library"
      @teacher.semester_id = 2
      @teacher.save
      @semester.can_create_course?.should == true
    end

    it 'I test can_create_course? when only ptainstructor exists' do
      @semester = Semester.new
      @semester.id = 2
      @semester.name = "Fall 2012"
      @semester.start_date = "08/22/12"
      @semester.end_date = "12/24/12"
      @semester.dates_with_no_classes = []
      @semester.lottery_deadline = "01/22/2012"
      @semester.registration_deadline = "01/22/12"
      @semester.fee = 200
      @semester.save
      @ptainstructor = Ptainstructor.new
      @ptainstructor.id = 2
      @ptainstructor.first_name = "Mary"
      @ptainstructor.last_name = "Katherine"
      @ptainstructor.email = "mary@gmail.com"
      @ptainstructor.phone = "925-987-1234"
      @ptainstructor.address = "1000 Main St. SF, CA 94109"
      @ptainstructor.bio = "I love math"
      @ptainstructor.semester_id = 2
      @ptainstructor.save
      @semester.can_create_course?.should == false
    end

    it 'I test can_create_course? when only teacher exists' do
      @semester = Semester.new
      @semester.id = 2
      @semester.name = "Fall 2012"
      @semester.start_date = "08/22/12"
      @semester.end_date = "12/24/12"
      @semester.dates_with_no_classes = []
      @semester.lottery_deadline = "01/22/2012"
      @semester.registration_deadline = "01/22/12"
      @semester.fee = 200
      @semester.save
      @teacher = Teacher.new
      @teacher.id = 3
      @teacher.name = "Jane"
      @teacher.grade = "2"
      @teacher.classroom = "Library"
      @teacher.semester_id = 2
      @teacher.save
      @semester.can_create_course?.should == false
    end

    it 'I test can_create_course? when ptainstructor and teacher have different semester ids' do
      @semester = Semester.new
      @semester.id = 2
      @semester.name = "Fall 2012"
      @semester.start_date = "08/22/12"
      @semester.end_date = "12/24/12"
      @semester.dates_with_no_classes = []
      @semester.lottery_deadline = "01/22/2012"
      @semester.registration_deadline = "01/22/12"
      @semester.fee = 200
      @semester.save
      @ptainstructor = Ptainstructor.new
      @ptainstructor.id = 2
      @ptainstructor.first_name = "Mary"
      @ptainstructor.last_name = "Katherine"
      @ptainstructor.email = "mary@gmail.com"
      @ptainstructor.phone = "925-987-1234"
      @ptainstructor.address = "1000 Main St. SF, CA 94109"
      @ptainstructor.bio = "I love math"
      @ptainstructor.semester_id = 1
      @ptainstructor.save
      @teacher = Teacher.new
      @teacher.id = 3
      @teacher.name = "Jane"
      @teacher.grade = "2"
      @teacher.classroom = "Library"
      @teacher.semester_id = 3
      @teacher.save
      @semester.can_create_course?.should == false
    end

  end


  describe 'Check if correct number of days is calculated in semester' do
    it 'I test specific_days_in_semester with semester over 2 months' do
      @semester = Semester.new
      @semester.id = 4
      @semester.name = "Spring 2013"
      @semester.start_date = "09/02/2012"
      @semester.end_date = "10/07/2012"
      @semester.dates_with_no_classes = []
      @semester.individual_dates_with_no_classes = []
      @semester.lottery_deadline = "01/22/2013"
      @semester.registration_deadline = "01/22/13"
      @semester.fee = 200
      @semester.save
    # @semester.individual_dates_with_no_classes.add("9/02/2012")
      date_hash = {7 => 6, 1 => 5, 2 => 5 , 3 => 5 , 4 => 5 , 5 => 5 , 6 => 5}
      answer_hash = @semester.specific_days_in_semester
      answer_hash.should == date_hash
    end


    it 'I test specific_days_in_semester with semester that passes through new year' do
      @semester = Semester.new
      @semester.id = 6
      @semester.name = "Spring 2013"
      @semester.start_date = "12/24/2012"
      @semester.end_date = "1/04/2013"
      @semester.dates_with_no_classes = []
      @semester.individual_dates_with_no_classes = []
      @semester.lottery_deadline = "01/22/2013"
      @semester.registration_deadline = "01/22/13"
      @semester.fee = 200
      @semester.save
      date_hash = {7 => 1, 1 => 2, 2 => 2 , 3 => 2 , 4 => 2 , 5 => 2 , 6 => 1}
      answer_hash = @semester.specific_days_in_semester
      answer_hash.should == date_hash
    end


    it 'I test specific_days_in_semester with semester without 2 and 4 digits' do
      @semester = Semester.new
      @semester.id = 7
      @semester.name = "Spring 2013"
      @semester.start_date = "9/2/12"
      @semester.end_date = "10/07/2012"
      @semester.dates_with_no_classes = []
      @semester.individual_dates_with_no_classes = []
      @semester.lottery_deadline = "01/22/2013"
      @semester.registration_deadline = "01/22/13"
      @semester.fee = 200
      @semester.save
      date_hash = {7 => 6, 1 => 5, 2 => 5 , 3 => 5 , 4 => 5 , 5 => 5 , 6 => 5}
      answer_hash = @semester.specific_days_in_semester
      answer_hash.should == date_hash
    end

  end


  describe 'Check if semester is properly imported' do
    it 'I test import with regular semester' do
      @semester1 = Semester.new
      @semester1.id = 2
      @semester1.name = "Fall 2012"
      @semester1.start_date = "08/22/12"
      @semester1.end_date = "12/24/12"
      @semester1.dates_with_no_classes = []
      @semester1.lottery_deadline = "01/22/2012"
      @semester1.registration_deadline = "01/22/12"
      @semester1.fee = 200
      @semester1.save
      @ptainstructor = Ptainstructor.new
      @ptainstructor.id = 2
      @ptainstructor.first_name = "Mary"
      @ptainstructor.last_name = "Katherine"
      @ptainstructor.email = "mary@gmail.com"
      @ptainstructor.phone = "925-987-1234"
      @ptainstructor.address = "1000 Main St. SF, CA 94109"
      @ptainstructor.bio = "I love math"
      @ptainstructor.semester_id = 2
      @ptainstructor.save
      @teacher = Teacher.new
      @teacher.id = 3
      @teacher.name = "Jane"
      @teacher.grade = "2"
      @teacher.classroom = "Library"
      @teacher.semester_id = 2
      @teacher.save
      @course = Course.new
      @course.id = 4
      @course.name = "Math"
      @course.description = "Math is amazing"
      @course.sunday = false
      @course.monday = true
      @course.tuesday = false
      @course.wednesday = true
      @course.thursday = false
      @course.friday = false
      @course.saturday = false
      @course.start_time = "2:00"
      @course.end_time = "5:00"
      @course.grade_range = "K-5"
      @course.class_min = 2
      @course.class_max = 20
      @course.number_of_classes = 10
      @course.fee_per_meeting = 20
      @course.fee_for_additional_materials = 30
      @course.course_fee = 100
      @course.semester_id = 2
      @course.ptainstructor_id = 2
      @course.teacher_id = 3
      @course.save
      @semester2 = Semester.new
      @semester2.id =3
      @semester2.name = "Spring 2013"
      @semester2.start_date = "01/22/12"
      @semester2.end_date = "02/24/12"
      @semester2.dates_with_no_classes = []
      @semester2.lottery_deadline = "01/22/2013"
      @semester2.registration_deadline = "01/22/13"
      @semester2.fee = 200
      @semester2.import(@semester1)
      @semester2.save
      @teachers = Teacher.find_by_semester_id(3)
      @ptainstructors = Ptainstructor.find_by_semester_id(3)
      @courses = Course.find_by_semester_id(3)
      @teacher_test = Teacher.new
      @teacher_test.id = 4
      @teacher_test.name = "Jane"
      @teacher_test.grade = "2"
      @teacher_test.classroom = "Library"
      @teacher_test.semester_id = 3
      @teachers.should == @teacher_test
      @ptainstructor_test = Ptainstructor.new
      @ptainstructor_test.id = 3
      @ptainstructor_test.first_name = "Mary"
      @ptainstructor_test.last_name = "Katherine"
      @ptainstructor_test.email = "mary@gmail.com"
      @ptainstructor_test.phone = "925-987-1234"
      @ptainstructor_test.address = "1000 Main St. SF, CA 94109"
      @ptainstructor_test.bio = "I love math"
      @ptainstructor_test.semester_id = 3
      @ptainstructors.should == @ptainstructor_test
      @course_test = Course.new
      @course_test.id = 5
      @course_test.name = "Math"
      @course_test.description = "Math is amazing"
      @course_test.sunday = false
      @course_test.monday = true
      @course_test.tuesday = false
      @course_test.wednesday = true
      @course_test.thursday = false
      @course_test.friday = false
      @course_test.saturday = false
      @course_test.start_time = "2:00"
      @course_test.end_time = "5:00"
      @course_test.grade_range = "K-5"
      @course_test.class_min = 2
      @course_test.class_max = 20
      @course_test.number_of_classes = 10
      @course_test.fee_per_meeting = 20
      @course_test.fee_for_additional_materials = 30
      @course_test.course_fee = 100
      @course_test.semester_id = 3
      @course_test.ptainstructor_id = 2
      @course_test.teacher_id = 3
      @courses.should == @course_test

    end
  end


  describe 'Test if date span is valid' do
    it 'I test dates_in_span_valid? with valid span' do
      @semester = Semester.new
      @semester.id = 4
      @semester.name = "Spring 2013"
      @semester.start_date = "01/22/12"
      @semester.end_date = "02/24/12"
      @semester.dates_with_no_classes = []
      @semester.individual_dates_with_no_classes = []
      @semester.lottery_deadline = "01/22/2013"
      @semester.registration_deadline = "01/22/13"
      @semester.fee = 200
      @semester.save
      @answer = @semester.dates_in_span_valid?("10/12/2012-10/23/2012")
      @answer.should == true
    end

    it 'I test dates_in_span_valid? with valid span, one date' do
      @semester = Semester.new
      @semester.id = 4
      @semester.name = "Spring 2013"
      @semester.start_date = "01/22/12"
      @semester.end_date = "02/24/12"
      @semester.dates_with_no_classes = []
      @semester.individual_dates_with_no_classes = []
      @semester.lottery_deadline = "01/22/2013"
      @semester.registration_deadline = "01/22/13"
      @semester.fee = 200
      @semester.save
      @answer = @semester.dates_in_span_valid?("10/12/2012")
      @answer.should == true
    end

    it 'I test dates_in_span_valid? with invalid span' do
      @semester = Semester.new
      @semester.id = 4
      @semester.name = "Spring 2013"
      @semester.start_date = "01/22/12"
      @semester.end_date = "02/24/12"
      @semester.dates_with_no_classes = []
      @semester.individual_dates_with_no_classes = []
      @semester.lottery_deadline = "01/22/2013"
      @semester.registration_deadline = "01/22/13"
      @semester.fee = 200
      @semester.save
      @answer = @semester.dates_in_span_valid?("10/12/2012-9/22/2012")
      @answer.should == false
    end

    it 'I test dates_in_span_valid? with invalid date' do
      @semester = Semester.new
      @semester.id = 4
      @semester.name = "Spring 2013"
      @semester.start_date = "01/22/12"
      @semester.end_date = "02/24/12"
      @semester.dates_with_no_classes = []
      @semester.individual_dates_with_no_classes = []
      @semester.lottery_deadline = "01/22/2013"
      @semester.registration_deadline = "01/22/13"
      @semester.fee = 200
      @semester.save
      @answer = @semester.dates_in_span_valid?("10/32/2012")
      @answer.should == false
    end

    it 'I test dates_in_span_valid? with invalid date 5' do
      @semester = Semester.new
      @semester.id = 4
      @semester.name = "Spring 2013"
      @semester.start_date = "01/22/12"
      @semester.end_date = "02/24/12"
      @semester.dates_with_no_classes = []
      @semester.individual_dates_with_no_classes = []
      @semester.lottery_deadline = "01/22/2013"
      @semester.registration_deadline = "01/22/13"
      @semester.fee = 200
      @semester.save
      @answer = @semester.dates_in_span_valid?("10")
      @answer.should == false
    end
  end
end




