class EnrollmentsController < ApplicationController
  protect_from_forgery
=begin
  def show
    #not used
    @semester = Semester.find_by_id params[:semester_id]
    return unless semester_is_valid(@semester)

    @student = Student.find_by_id params[:student_id]
    return unless student_is_valid(@student, @semester)

    redirect_to edit_semester_student_path(@semester, @student)
  end

  def index
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
=end

  def create
    @semester = Semester.find_by_id params[:semester_id]
    return unless semester_is_valid(@semester)


    @student = Student.find_by_id params[:student_id]
    return unless student_is_valid(@student, @semester)

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
      flash[:student] = @enrollment
    end

    redirect_to edit_semester_student_path(@semester, @student)
  end
=begin
  def edit
    @semester = Semester.find_by_id params[:semester_id]
    return unless semester_is_valid(@semester)


    @student = Student.find_by_id params[:student_id]
    return unless student_is_valid(@student, @semester)

    redirect_to edit_semester_student_path(@semester, @student)
  end
=end
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
    return unless semester_is_valid(@semester)

    @student = Student.find_by_id params[:student_id]
    return unless student_is_valid(@student, @semester)

    @enrollment = Enrollment.find_by_id params[:id]

    if not @enrollment
      flash[:warning] = [[:enrollment, "Could not find the enrollment that was selected for deletion"]]
      redirect_to edit_semester_student_path(@semester, @student)
      return
    end

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


  private
  def semester_is_valid(semester, message="Error: Unable to find the semester for the enrollment.")
    if not semester
      flash[:warning] = [[:semester_id, message]]
      redirect_to semesters_path, :method => :get
      return false
    end
    return true
  end

  private
  def student_is_valid(student, semester, message = "Unable to find a student that matches the given id.")
    if not student
      flash[:warning] = [[:student, message]]
      redirect_to semester_students_path(semester)
    end
    return true
  end
end
