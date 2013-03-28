class EnrollmentsController < ApplicationController
  protect_from_forgery

  def index
    @semester = Semester.find_by_id params[:semester_id]
    return unless valid_semester?(@semester)

    @enrollments = @semester.find_by_id params[:student_id]
    return unless student_is_valid(@student, @semester)

    redirect_to edit_semester_student_path(@semester, @student)
  end
  
  def show
    #not used
    @semester = Semester.find_by_id params[:semester_id]
    return unless semester_is_valid(@semester)

    @student = Student.find_by_id params[:student_id]
    return unless student_is_valid(@student, @semester)

    redirect_to edit_semester_student_path(@semester, @student)
  end

  def new
    #not used
    #redirect_to semester_students_path
    @semester = Semester.find_by_id params[:semester_id]
    return unless semester_is_valid(@semester)

    @student = Student.find_by_id params[:student_id]
    return unless student_is_valid(@student, @semester)

    redirect_to edit_semester_student_path(@semester, @student)
  end
 
  def create
    @semester = Semester.find_by_id params[:semester_id]
    return unless valid_semester?(@semester)

    @student = Student.find_by_id params[:student_id]
    return unless valid_student?(@student)

    #Check if the course has already been added
    enrolled = Enrollment.where(:student_id => @student.id, :course_id => params[:enrollment][:course_id])
    if enrolled.length == 0
      #The student has not been enrolled in this course
      @enrollment = Enrollment.new(params[:enrollment])
      if not @enrollment
        flash[:warning] = [[:enrollment,"Could not initialize a enrollment object."]]
        redirect_to new_semester_student_enrollment_path(@semester)
        return
      end

      @enrollment.semester_id = @semester.id
      @enrollment.student_id = @student.id

      if @enrollment.save
        flash[:notice] = "#{@student.first_name} #{@student.last_name} was successfully enrolled in #{@enrollment.course.name}."
      else
        flash[:warning] = @enrollment.errors
        flash[:enrollment] = params[:enrollment]
      end
    else
      # The student has been enrolled in this course.  Update it instead of creating a new one.
      @enrollment = enrolled[0]
      @enrollment.update_attributes(params[:enrollment])
      if @enrollment.save
        flash[:notice] = "#{@student.first_name} #{@student.last_name}'s enrollment in #{@enrollment.course.name} was successfully updated."
      else
        flash[:warning] = @enrollment.errors
        flash[:enrollment] = params[:enrollment]
      end
    end
    redirect_to edit_semester_student_path(@semester, @student)
  end
 
  def edit
    @semester = Semester.find_by_id params[:semester_id]
    return unless semester_is_valid(@semester)


    @student = Student.find_by_id params[:student_id]
    return unless student_is_valid(@student, @semester)

    redirect_to edit_semester_student_path(@semester, @student)
  end

  def update
    @semester = Semester.find_by_id params[:semester_id]
    return unless semester_is_valid(@semester)

    @student = Student.find_by_id params[:student_id]
    return unless student_is_valid(@student, @semester)

    @course = Course.find_by_id[:course]
    if not @course
      flash[:warning] = [[:course, "No course was selected"]]
      return
    end
  end

  def destroy
    @semester = Semester.find_by_id params[:semester_id]
    return unless valid_semester?(@semester)

    @student = Student.find_by_id params[:student_id]
    return unless valid_student?(@student)

    @enrollment = Enrollment.find_by_id params[:id]
    return unless valid_enrollment?(@enrollment)

    first_name = @student.first_name
    last_name = @student.last_name
    course_name = @enrollment.course.name

    if @enrollment.destroy
      flash[:notice] = "Successfully deleted #{first_name} #{last_name}'s enrollment in #{course_name}"
    else
      flash[:warning] = @enrollment.errors
    end
    redirect_to edit_semester_student_path(@semester, @student)
  end
end
