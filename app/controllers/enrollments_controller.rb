class EnrollmentsController < ApplicationController
  protect_from_forgery
	layout "main"
	
	helper_method :days
	
  def site_section
  	:enrollments_section
  end

  def index
    @semester = Semester.find(params[:semester_id])
    return unless valid_semester?(@semester)
    
    @filter = Hash.new
    if (params[:filter_teacher])
    	@filter[:teacher] = @semester.teachers.find(params[:filter_teacher])
    end
    if (params[:filter_dismissal])
    	@filter[:dismissal] = dismissals[params[:filter_dismissal].to_i]
    end

    @enrollments = @semester.enrollments.enrolled.with_teacher(params[:filter_teacher]).with_dismissal(params[:filter_dismissal]).by_course_day_and_student_name
    
    @enrollments_by_day = Hash.new { |hash, key| hash[key] = Array.new }
    @enrollments.each do |enrollment|
      @enrollments_by_day[:sunday] << enrollment if enrollment.course.sunday
    	if enrollment.course.monday
    		@enrollments_by_day[:monday] << enrollment
    	end
    	if enrollment.course.tuesday
    		@enrollments_by_day[:tuesday] << enrollment
    	end
    	if enrollment.course.wednesday
    		@enrollments_by_day[:wednesday] << enrollment
    	end
    	if enrollment.course.thursday
    		@enrollments_by_day[:thursday] << enrollment
    	end
    	if enrollment.course.friday
    		@enrollments_by_day[:friday] << enrollment
    	end
    	if enrollment.course.saturday
    		@enrollments_by_day[:saturday] << enrollment
    	end
    end
    
    @all_teachers = @semester.teachers
    @all_dismissals = dismissals
  end
  
  def days
  	ApplicationHelper::WEEKDAYS
  end
  
  def dismissals
  	ApplicationHelper::DISMISSALS
  end
end
