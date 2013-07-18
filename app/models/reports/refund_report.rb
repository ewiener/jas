class RefundReport < Report
	attr_reader :refunds, :total_refund, :total_enrollment_refund
	
	RefundData = Struct.new(:enrollment, :enrollment_refund, :total_refund)
	
	def name
		"Refund Report"
	end
	
	private
	def init_report
		@refunds = Array.new
		@total_refund = 0
		@total_enrollment_refund = 0
		
		processed_students = Hash.new
		refund_enrollments = @semester.enrollments.disenrolled.by_student_name
		refund_enrollments.each do |enrollment|
			enrollment_refund = enrollment.course.total_fee - enrollment.scholarship_amount
			refund_data = RefundData.new(enrollment, enrollment_refund, enrollment_refund)
			if !processed_students[enrollment.student] && !enrollment.student.enrolled?
				# They're not enrolled in any other classes and this is the first instance
				# of the student in the report, so add the session reg fee to the total
				refund_data.total_refund = enrollment_refund + @semester.fee
				processed_students[enrollment.student] = :true
			end
			@refunds << refund_data
			
			@total_refund = @total_refund + refund_data.total_refund
			@total_enrollment_refund = @total_enrollment_refund + refund_data.enrollment_refund
		end
	end
end