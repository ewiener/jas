class StudentsController < ApplicationController
  protect_from_forgery
  layout "main"

  def site_section
  	:students_section
  end

  def index
    @semester = Semester.find(params[:semester_id])
    return unless valid_semester?(@semester)

    @students = @semester.students.by_name
    @filter = Hash.new

    if (params[:filter_enrolled] == 'true')
    	@students = @students.select{|student| student.enrolled?}
    	@filter[:enrolled] = 'true'
    elsif (params[:filter_enrolled] == 'false')
    	@students = @students.select{|student| !student.enrolled?}
    	@filter[:enrolled] = 'false'
    end
  end

  def show
    @student = Student.find(params[:id])
    return unless valid_student?(@student)

    @semester = params.include?(:semester_id) ? Semester.find(params[:semester_id]) : @student.semester
    return unless valid_semester?(@semester)

	  @enrollments = @student.enrollments.by_course_day_and_course_name
  end

  def new
    @semester = Semester.find(params[:semester_id])
    return unless valid_semester?(@semester)

    @student = flash.key?(:student) ? Student.new(flash[:student]) : Student.new

    @classrooms = @semester.classrooms.with_teacher.by_grade_and_teacher
  end

  def create
    @semester = Semester.find(params[:semester_id])
    return unless valid_semester?(@semester)

    @student = @semester.students.build(params[:student])

    @classroom = params[:classroom] && !params[:classroom].empty? ? Classroom.find(params[:classroom]) : nil
    if @classroom
      @student.classroom = @classroom
    else
      flash[:warning] = [[:classroom,"Must select a valid teacher."]]
      flash[:student] = params[:student] # Save fields so the user doesn't have to re-enter everything again
      redirect_to new_semester_student_path(@semester)
      return
    end

    if @student.save
      redirect_to student_path(@student), :notice => "#{@student.first_name} #{@student.last_name} was successfully added to the database."
    else
      flash[:warning] = @student.errors
      flash[:student] = params[:student] # Save fields so the user doesn't have to re-enter everything again
      redirect_to new_semester_student_path(@semester)
    end
  end

  def edit
    @student = Student.find(params[:id])
    return unless valid_student?(@student)

    @semester = params.include?(:semester_id) ? Semester.find(params[:semester_id]) : @student.semester
    return unless valid_semester?(@semester)

    @classrooms = @semester.classrooms.with_teacher.by_grade_and_teacher
  end

  def update
    @student = Student.find(params[:id])
    return unless valid_student?(@student)

    @semester = params.include?(:semester_id) ? Semester.find(params[:semester_id]) : @student.semester
    return unless valid_semester?(@semester)

    @student.assign_attributes(params[:student])

    @classroom = Classroom.find(params[:classroom])
    if @classroom
      @student.classroom = @classroom
    else
      flash[:warning] = [[:classroom,"A valid classroom was not selected."]]
      flash[:student] = params[:student] # Save fields so the user doesn't have to re-enter everything again
      redirect_to edit_student_path
    end

    if @student.save
      redirect_to student_path(@student), :notice => "#{@student.first_name} #{@student.last_name}'s information was successfully updated."
    else
      flash[:warning] = @student.errors
      flash[:student] = params[:student] # Save fields so the user doesn't have to re-enter everything again
      redirect_to edit_student_path
    end
  end

  def destroy
    @student = Student.find(params[:id])
    return unless valid_student?(@student)

    @semester = params.include?(:semester_id) ? Semester.find(params[:semester_id]) : @student.semester
    return unless valid_semester?(@semester)

    if @student.destroy
      flash[:notice]= "#{@student.first_name} #{@student.last_name} was successfully deleted."
    else
      flash[:warning] = @student.errors
    end

    redirect_to semester_students_path(@semester)
  end

  def index_enrollments
    @student = Student.find(params[:id])
    return unless valid_student?(@student)

    @semester = params.include?(:semester_id) ? Semester.find(params[:semester_id]) : @student.semester
    return unless valid_semester?(@semester)

	  @enrollments = @student.enrollments.by_course_day_and_course_name

  	render 'students/enrollments/index'
  end

  def show_enrollment
    @student = Student.find(params[:id])
    return unless valid_student?(@student)

    @course = Course.find(params[:course_id])
    return unless valid_course?(@course)

    @semester = params.include?(:semester_id) ? Semester.find(params[:semester_id]) : @course.semester
    return unless valid_semester?(@semester)

    @enrollment = @student.find_enrollment(@course)
    return unless valid_enrollment?(@enrollment)

  	render 'students/enrollments/show'
  end

  def new_enrollment
    @student = Student.find(params[:id])
    return unless valid_student?(@student)

    @semester = params.include?(:semester_id) ? Semester.find(params[:semester_id]) : @student.semester
    return unless valid_semester?(@semester)

    @classes = @semester.courses.by_day_and_name.reject { |course| @student.has_enrollment(course) }
    if @student.grade == 'K'
      @classes = @classes.select { |course| course.allows_kindergarten }
    else
      @classes = @classes.reject { |course| course.only_kindergarten }
    end

    @enrollment = flash.key?(:enrollment) ? Enrollment.new(flash[:enrollment]) : Enrollment.new

  	render 'students/enrollments/new'
  end

  def edit_enrollment
    @student = Student.find(params[:id])
    return unless valid_student?(@student)

    @course = Course.find(params[:course_id])
    return unless valid_course?(@course)

    @semester = params.include?(:semester_id) ? Semester.find(params[:semester_id]) : @course.semester
    return unless valid_semester?(@semester)

    @enrollment = @student.find_enrollment(@course)
    return unless valid_enrollment?(@enrollment)

    @classes = @semester.courses.by_day_and_name.reject { |course| @student.has_enrollment(course) }

  	render 'students/enrollments/edit'
  end

  def create_enrollment
    @student = Student.find(params[:id])
    return unless valid_student?(@student)

    @course = params[:enrollment][:course_id].present? ? Course.find(params[:enrollment][:course_id]) : nil
    return unless valid_course?(@course, student_path(@student))

    @semester = params.include?(:semester_id) ? Semester.find(params[:semester_id]) : @course.semester
    return unless valid_semester?(@semester)

    @enrollment = @student.find_enrollment(@course)
    if @enrollment.nil?
      # Student not already enrolled, enroll them
      @enrollment = @student.create_enrollment(params[:enrollment])
      if not @enrollment.new_record?
        flash[:notice] = "#{@student.first_name} #{@student.last_name} was successfully enrolled in #{@course.name}."
      else
        flash[:warning] = @enrollment.errors
        flash[:enrollment] = params[:enrollment]
      end
    else
      # Student already enrolled, just update the enrollment record
      if @enrollment.update_attributes(params[:enrollment])
        flash[:notice] = "#{@student.first_name} #{@student.last_name}'s enrollment in #{@course.name} was successfully updated."
      else
        flash[:warning] = @enrollment.errors
        flash[:enrollment] = params[:enrollment]
      end
    end
    redirect_to student_path
  end

  def destroy_enrollment
    @student = Student.find_by_id params[:id]
    return unless valid_student?(@student)

    @course = Course.find(params[:course_id])
    return unless valid_course?(@course)

    @enrollment = @student.find_enrollment(@course)
    if @enrollment.nil?
      flash[:warning] = [[:enrollment, "Couldn't unenroll, the given student is not enrolled for the given course."]]
      redirect_to edit_student_path
      return
    end

    if @enrollment.destroy
      flash[:notice] = "#{@student.first_name} #{@student.last_name} was successfully unenrolled from #{@course.name}"
    else
      flash[:warning] = @enrollment.errors
    end
    redirect_to student_path
  end
end
