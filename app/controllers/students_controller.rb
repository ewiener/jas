class StudentsController < ApplicationController
  protect_from_forgery

  def show
    #Not currently used
    #@student = Student.find_by_id params[:id]
    #return unless student_is_valid(@student)
  end

  def index
    if params[:semester_id]
      @semester = Semester.find_by_id params[:semester_id]
      if not @semester
        flash[:warning] = [[:semester_id, "Unable to locate the specified semester."]]
        redirect_to semesters_path
        return
      end
    else
      flash[:warning] = [[:semester_id, "No semester was given."]]
      redirect_to semesters_path
      return
    end
    @students = Student.find_all_by_semester_id(@semester, :order => "last_name asc")
  end

  def new
    @semester = Semester.find_by_id params[:semester_id]
    return unless semester_is_valid(@semester)
    @classes = Course.where( :semester_id => @semester)
    @teachers = Teacher.where( :semester_id => @semester )
    if flash.key? :student
      @student = flash[:student]
      render 'new'
      return
    end
  end

 def create
   @semester = Semester.find_by_id params[:semester_id]
   return unless semester_is_valid(@semester)

   @student = Student.new(params[:student])
   #return unless student_is_valid(@student,"Could not initialize a student object.")
   if not @student
     flash[:warning] = [[:student,"Could not initialize a student object."]]
     redirect_to new_semester_student_path(@semester)
     return
   end

   @student.semester_id = @semester.id

   """
   @courses = Course.find_all_by_id(params[:courses])
   if @courses
     @student.courses = @courses
   end
   """
   @teacher = Teacher.find_by_id params[:teacher]
   if @teacher
     @student.teacher_id = @teacher.id
   else
     flash[:warning] = [[:teacher,"A valid teacher was not selected."]]
     flash[:student] = @student
     redirect_to new_semester_student_path(@semester)
     return
   end

   if @student.save
     flash[:notice] = "#{@student.first_name} #{@student.last_name} was successfully added to the database."
     redirect_to semester_students_path
   else
     flash[:warning] = @student.errors
     flash[:student] = @student
     redirect_to new_semester_student_path(@semester)
   end
=begin
   @student = @semester.students.create(params[:student])
   if @student.new_record?
     flash[:warning] = @student.errors
     flash[:student] = @student
     redirect_to new_semester_student_path(@semester)
     return
   else
     flash[:notice] = "#{@student.first_name} #{@student.last_name} was successfully added to the database."
     redirect_to semester_students_path
   end
=end
 end

  def edit
    @semester = Semester.find_by_id params[:semester_id]
    return unless semester_is_valid(@semester)
    @classes = Course.where( :semester_id => @semester)
    @teachers = Teacher.where( :semester_id => @semester )
    @student = Student.find_by_id params[:id]
    return unless student_is_valid(@student)
    @enrollments = Enrollment.find_all_by_student_id @student.id
  end

  def update
    @semester = Semester.find_by_id params[:semester_id]
    @student = Student.find_by_id params[:id]
    return unless student_is_valid(@student)

    @student.assign_attributes(params[:student])

    """
    @courses = Course.find_all_by_id(params[:courses])
    if @courses
      @student.courses = @courses
    else
      @student.courses = nil
    end
    """

    @teacher = Teacher.find_by_id params[:teacher]
    if @teacher
      @student.teacher_id = @teacher.id
    else
      flash[:warning] = [[:teacher,"A valid teacher was not selected."]]
      flash[:student] = @student
      redirect_to new_semester_student_path(@semester)
      return
    end

    if @student.save
      flash[:notice] = "#{@student.first_name} #{@student.last_name}'s information was successfully updated."
      redirect_to semester_students_path(@semester)
    else
      flash[:warning] = @student.errors
      flash[:student] = @student
      redirect_to edit_semester_student_path(@semester,@student)
    end
  end

  def destroy
    @student = Student.find_by_id params[:id]
    return unless student_is_valid(@student)

    name = "#{@student.first_name} #{@student.last_name}"

    if @student.destroy
      flash[:notice]= "#{name} was successfully deleted."
    else
      flash[:warning] = @student.errors
    end

    redirect_to semester_students_path
  end

  private
  def student_is_valid(student,message="Could not find the corresponding student.")
    if(student == nil)
      flash[:warning] = [[:id,message]]
      redirect_to semester_students_path
      return false
    end
    return true
  end

  private
  def semester_is_valid(semester, message="Error: Unable to find the semester for the student.")
    if not semester
      flash[:warning] = [[:semester_id, message]]
      redirect_to semesters_path, :method => :get
      return false
    end
    return true
  end
end
