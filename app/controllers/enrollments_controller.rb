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
    	@filter[:teacher] = @semester.classrooms.find(params[:filter_teacher])
    end
    if (params[:filter_dismissal])
    	@filter[:dismissal] = dismissals[params[:filter_dismissal].to_i]
    end

    @view = Hash.new
    if (params[:view_by_student])
      # Don't group by day
      @view[:by_student] = true
    end
    if (params[:view_by_grade])
    	@view[:by_grade] = true
    end
    if (params[:view_disenrolled])
      @view[:disenrolled] = true
    end

    @enrollments = @semester.enrollments.with_teacher(params[:filter_teacher]).with_dismissal(params[:filter_dismissal])
    if !@view[:disenrolled]
      @enrollments = @enrollments.enrolled
    end
    if @view[:by_student]
      if @view[:by_grade]
        @enrollments = @enrollments.by_grade_and_student_name_and_course_day
      else
        @enrollments = @enrollments.by_student_name_and_course_day
      end
    else
      if @view[:by_grade]
        @enrollments = @enrollments.by_course_day_and_grade_and_student_name
      else
        @enrollments = @enrollments.by_course_day_and_student_name
      end
    end

    @enrollments_by_day = Hash.new { |hash, key| hash[key] = Array.new }
    @enrollments.each do |enrollment|
      @enrollments_by_day[:sunday] << enrollment if enrollment.course.sunday
      @enrollments_by_day[:monday] << enrollment if enrollment.course.monday
      @enrollments_by_day[:tuesday] << enrollment if enrollment.course.tuesday
  		@enrollments_by_day[:wednesday] << enrollment if enrollment.course.wednesday
  		@enrollments_by_day[:thursday] << enrollment if enrollment.course.thursday
  		@enrollments_by_day[:friday] << enrollment if enrollment.course.friday
  		@enrollments_by_day[:saturday] << enrollment if enrollment.course.saturday
    end

    @all_teachers = @semester.classrooms.with_teacher.by_grade_and_teacher
    @all_dismissals = dismissals
  end

  def days
  	ApplicationHelper::WEEKDAYS
  end

  def dismissals
  	ApplicationHelper::DISMISSALS
  end
end
