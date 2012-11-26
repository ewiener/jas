require 'spec_helper'

describe Enrollment do
  describe 'Test if dismissal is valid' do
    it 'I test dismissal_is_valid? with valid input 0' do
      @enrollment = Enrollment.new
      @enrollment.dismissal = 0
      @enrollment.dismissal_is_valid?.should == true
    end

    it 'I test dismissal_is_valid? with valid input 3' do
      @enrollment = Enrollment.new
      @enrollment.dismissal = 3
      @enrollment.dismissal_is_valid?.should == true
    end

    it 'I test dismissal_is_valid? with invalid input 4' do
      @enrollment = Enrollment.new
      @enrollment.dismissal = 4
      @enrollment.dismissal_is_valid?.should == false
    end

    it 'I test dismissal_is_valid? with invalid input -1' do
      @enrollment = Enrollment.new
      @enrollment.dismissal = -1
      @enrollment.dismissal_is_valid?.should == false
    end

    it 'I test dismissal_is_valid? with invalid input nil' do
      @enrollment = Enrollment.new
      @enrollment.dismissal_is_valid?.should == false
    end
  end

  describe 'Test if scholarship is valid' do
    it 'I test scholarship_is_valid? with valid input 0' do
      @enrollment = Enrollment.new
      @enrollment.scholarship = 0
      @enrollment.scholarship_is_valid?.should == true
    end

    it 'I test scholarship_is_valid? with valid input 2' do
      @enrollment = Enrollment.new
      @enrollment.scholarship = 2
      @enrollment.scholarship_is_valid?.should == true
    end

    it 'I test scholarship_is_valid? with invalid input -1' do
      @enrollment = Enrollment.new
      @enrollment.scholarship = -1
      @enrollment.scholarship_is_valid?.should == false
    end

    it 'I test scholarship_is_valid? with invalid input 3' do
      @enrollment = Enrollment.new
      @enrollment.scholarship = 3
      @enrollment.scholarship_is_valid?.should == false
    end

    it 'I test scholarship_is_valid? with invalid input nil' do
      @enrollment = Enrollment.new
      @enrollment.scholarship_is_valid?.should == false
    end
  end

  describe 'Test if scholarship amount is valid' do
    it 'I test scholarship_amount_is_valid? with valid amount 0' do
      @enrollment = Enrollment.new
      @enrollment.scholarship_amount = 0
      @enrollment.scholarship_amount_is_valid?.should == true
    end

    it 'I test scholarship_amount_is_valid? with valid amount 1000' do
      @enrollment = Enrollment.new
      @enrollment.scholarship_amount = 1000
      @enrollment.scholarship_amount_is_valid?.should == true
    end

    it 'I test scholarship_amount_is_valid? with invalid amount -1' do
      @enrollment = Enrollment.new
      @enrollment.scholarship_amount = -1
      @enrollment.scholarship_amount_is_valid?.should == false
    end

    it 'I test scholarship_amount_is_valid? with invalid amount nil' do
      @enrollment = Enrollment.new
      @enrollment.scholarship_amount_is_valid?.should == false
    end
  end

  describe 'Test if enrollment is valid' do
    it 'I test enrollment_is_valid? with valid amount true' do
      @enrollment = Enrollment.new
      @enrollment.enrolled = true
      @enrollment.enrollment_is_valid?.should == true
    end

    it 'I test enrollment_is_valid? with valid amount false' do
      @enrollment = Enrollment.new
      @enrollment.enrolled = false
      @enrollment.enrollment_is_valid?.should == true
    end

    it 'I test enrollment_is_valid? with invalid amount nil' do
      @enrollment = Enrollment.new
      @enrollment.enrollment_is_valid?.should == false
    end
  end

  describe 'Test if semester id is valid' do
    it 'I test semester_id_is_valid? when semester_id is valid' do
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
      @enrollment = Enrollment.new
      @enrollment.semester_id = 2
      @enrollment.semester_id_is_valid?.should == true
    end

    it 'I test semester_id_is_valid? when semester_id is invalid' do
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
      @enrollment = Enrollment.new
      @enrollment.semester_id = 3
      @enrollment.semester_id_is_valid?.should == false
    end
  end

  describe 'Test if course id is valid' do
    it 'I test course_id_is_valid? when course_id is valid' do
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
      @course.total_fee = 230
      @course.semester_id = 2
      @course.ptainstructor_id = 2
      @course.teacher_id = 3
      @course.save
      @enrollment = Enrollment.new
      @enrollment.course_id = 4
      @enrollment.course_id_is_valid?.should == true
    end

    it 'I test course_id_is_valid? when course_id is not valid' do
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
      @course.total_fee = 230
      @course.semester_id = 2
      @course.ptainstructor_id = 2
      @course.teacher_id = 3
      @course.save
      @enrollment = Enrollment.new
      @enrollment.course_id = 3
      @enrollment.course_id_is_valid?.should == false
    end
  end

  describe 'Test if student id is valid' do
    it 'I test student_id_is_valid? when student_id is valid' do
      @student = Student.new
      @student.id = 1
      @student.first_name = "Bob"
      @student.last_name = "Smith"
      @student.grade = "K"
      @student.parent_phone = "415-123-4567"
      @student.parent_phone2 = "415-456-7899"
      @student.parent_name = "Jane Johnson"
      @student.parent_email = "jjohnson@gmail.com"
      @student.health_alert = "Allergic to peanuts"
      @student.semester_id = 2
      @student.teacher_id = 2
      @student.save
      @enrollment = Enrollment.new
      @enrollment.student_id = 1
      @enrollment.student_id_is_valid?.should == true
    end

    it 'I test student_id_is_valid? when student_id is invalid' do
      @student = Student.new
      @student.id = 1
      @student.first_name = "Bob"
      @student.last_name = "Smith"
      @student.grade = "K"
      @student.parent_phone = "415-123-4567"
      @student.parent_phone2 = "415-456-7899"
      @student.parent_name = "Jane Johnson"
      @student.parent_email = "jjohnson@gmail.com"
      @student.health_alert = "Allergic to peanuts"
      @student.semester_id = 2
      @student.teacher_id = 2
      @student.save
      @enrollment = Enrollment.new
      @enrollment.student_id = 2
      @enrollment.student_id_is_valid?.should == false
    end
  end
end



