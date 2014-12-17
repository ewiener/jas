class BalanceReport < Report
	attr_reader :total_revenue
	attr_reader :total_student_fee, :total_student_class_fee, :total_student_registration_fee
	attr_reader :total_student_registration_fee_waived

	attr_reader :total_expenses
	attr_reader :total_student_refund, :total_student_class_refund, :total_student_registration_refund
	attr_reader :total_instructor_fee
	attr_reader :total_instructor_scholarship_amount
	attr_reader :district_surcharge_amount
	attr_reader :district_surcharge_factor

	attr_reader :total_scholarship_amount

	attr_reader :balance

	def name
		"Balance Report"
	end

	private
	def init_report
		@total_student_fee = @total_student_class_fee = @total_student_registration_fee = 0
		@total_student_refund = @total_student_class_refund = @total_student_registration_refund = 0
		@total_student_registration_fee_waived = @semester.registration_fees_waived || 0
		@total_instructor_fee = 0
		@total_instructor_scholarship_amount = 0
		@total_scholarship_amount = 0
		@balance = 0

    processed_disenrolled_students = Hash.new

    @semester.enrollments.each do |enrollment|
      @total_student_class_fee += enrollment.total_fee
      if enrollment.enrolled?
    	  @total_scholarship_amount += enrollment.scholarship_amount
        @total_instructor_fee += enrollment.course.total_fee
      else
        @total_student_class_refund += enrollment.total_fee
				if !processed_disenrolled_students[enrollment.student] && !enrollment.student.enrolled?
					# They're not enrolled in any other classes and this is the first instance
					# of the student in the report, so add the session reg fee to the total
					@total_student_registration_refund += @semester.fee
					processed_disenrolled_students[enrollment.student] = :true
				end
      end
    end
    @semester.students.each do |student|
      if student.enrolled?
        @total_student_registration_fee += student.registration_fee
      end
    end
    @semester.courses.each do |course|
      if course.num_valid_enrollments > 0 && course.instructor_scholarships.to_i > 0
        @total_instructor_scholarship_amount = @total_instructor_scholarship_amount + course.total_fee * course.instructor_scholarships.to_i
      end
    end
    @total_student_fee = @total_student_class_fee + @total_student_registration_fee
    @total_student_refund = @total_student_class_refund + @total_student_registration_refund

    @district_surcharge_factor = @semester.district_surcharge || 0
    @district_surcharge_amount = (@total_instructor_fee - @total_instructor_scholarship_amount) * @district_surcharge_factor

    @total_revenue = @total_student_fee - @total_student_refund - @total_student_registration_fee_waived
    @total_expenses = @total_instructor_fee - @total_instructor_scholarship_amount + @district_surcharge_amount
    @balance = @total_revenue - @total_expenses
	end
end