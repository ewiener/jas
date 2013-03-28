class StudentsController < ApplicationController
  protect_from_forgery

  def index
    @semester = Semester.find(params[:semester_id])
    return unless valid_semester?(@semester)
    
    if (params[:conditions])
    	@students = @semester.students.where(params[:conditions])
    else
      @students = @semester.students
    end
  end
  
  def show
  	redirect_to edit_student_path
  end

  def new
    @semester = Semester.find(params[:semester_id])
    return unless valid_semester?(@semester)
    
    @student = flash.key?(:student) ? Student.new(flash[:student]) : Student.new
  end

  def create
    @semester = Semester.find(params[:semester_id])
    return unless valid_semester?(@semester)

    @student = @semester.students.build(params[:student])
    
    @teacher = Teacher.find(params[:teacher])
    if @teacher
      @student.teacher = @teacher
    else
      flash[:warning] = [[:teacher,"A valid teacher was not selected."]]
      flash[:student] = params[:student] # Save fields so the user doesn't have to re-enter everything again
      redirect_to edit_student_path
    end

    if @student.save
      redirect_to semester_students_path, :notice => "#{@student.first_name} #{@student.last_name} was successfully added to the database."
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

    @classes = @semester.courses
    @classes.unshift(Course.new(:name => "Select Item:"))
    @classes.each do |course|
      course.modify_name_for_enrollments(@student.id)
    end     

    @enrollment = flash.key?(:enrollment) ? Enrollment.new(flash[:enrollment]) : Enrollment.new
  end

  def update
    @student = Student.find(params[:id])
    return unless valid_student?(@student)

    @semester = params.include?(:semester_id) ? Semester.find(params[:semester_id]) : @student.semester
    return unless valid_semester?(@semester)
    
    @student.assign_attributes(params[:student])

    @teacher = Teacher.find(params[:teacher])
    if @teacher
      @student.teacher = @teacher
    else
      flash[:warning] = [[:teacher,"A valid teacher was not selected."]]
      flash[:student] = params[:student] # Save fields so the user doesn't have to re-enter everything again
      redirect_to edit_student_path
    end

    if @student.save 
      redirect_to semester_students_path(@semester), :notice => "#{@student.first_name} #{@student.last_name}'s information was successfully updated."
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
  
  def enroll
    @student = Student.find(params[:id])
    return unless valid_student?(@student)

    @semester = params.include?(:semester_id) ? Semester.find(params[:semester_id]) : @student.semester
    return unless valid_semester?(@semester)

    @enrollment = @student.find_enrollment(params[:enrollment][:course_id])
    if @enrollment.nil?
      # Student not already enrolled, enroll them
      @enrollment = @student.create_enrollment(params[:enrollment])
      if not @enrollment.new_record?
        flash[:notice] = "#{@student.first_name} #{@student.last_name} was successfully enrolled in #{@enrollment.course.name}."
      else
        flash[:warning] = @enrollment.errors
        flash[:enrollment] = params[:enrollment]
      end
    else
      # Student already enrolled, just update the enrollment record
      if @enrollment.update_attributes(params[:enrollment])
        flash[:notice] = "#{@student.first_name} #{@student.last_name}'s enrollment in #{@enrollment.course.name} was successfully updated."
      else
        flash[:warning] = @enrollment.errors
        flash[:enrollment] = params[:enrollment]
      end
    end
    redirect_to edit_student_path
  end
  
  def unenroll
    @student = Student.find_by_id params[:id]
    return unless valid_student?(@student)
    
    @enrollment = @student.find_enrollment(params[:course_id])
    if @enrollment.nil?
      flash[:warning] = [[:enrollment, "Couldn't unenroll, the given student is not enrolled for the given course."]]
      redirect_to edit_student_path
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
    redirect_to edit_student_path
  end
end
