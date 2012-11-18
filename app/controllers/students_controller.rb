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
    @students = Student.find_all_by_semester_id
  end

  def new
    @semester = Semester.find_by_id params[:semester_id]
    return unless semester_is_valid(@semester)
    if flash.key? :student
      @student = flash[:student]
      render 'new'
      return
    end
  end

 def create
   @semester = Semester.find_by_id params[:semester_id]
   return unless semester_is_valid(@semester)

   @student = @semester.student.create(params[:student])
   if @student.new_record?
     flash[:warning] = @student.errors
     flash[:student] = @student
     redurect_to new_semester_student_path(@semester)
     return
   else
     flash[:notice] = "#{@student.first_name} #{@student.last_name} was successfully added to the database."
     redirect_to semester_students_path(@student)
   end
 end

  def edit
    @semester = Semester.find_by_id params[:semster_id]
    return unless semster_is_valid(@semester)
    @student = Student.find_by_id params[:id]
    return unless student_is_valid(@student)
  end

  def update
    @semester = Semester.find_by_id params[:semester_id]
    @student = Student.find_by_id params[:id]
    return unless student_is_valid(@student)

    if @student.update_attributes(params[:student])
      flash[:notice] = "#{@student.first_name} #{student.last_name}'s information was successfully updated."
      redirect_to semester_student_path(@semester)
    else
      flash[:warning] = @student.errors
      redirect_to edit_semester_student_path(@semester,@student)
    end
  end

  def destroy
    @student = Student.find_by_id params[:id]
    return unless student_is_valid(@student)

    name = "{@student.first_name} {@student.last_name}"

    if @student.destroy
      flash[:notice]= "#{name} was successfully deleted."
    else
      flash[:warning] = @student.errors
    end

    redirect_to semester_students_path
  end

  private
  def student_is_valid(student)
    if(stutdent == nil)
      flash[:warning] = [[:id,"Could not find the corresponding student."]]
      redirect_to semesters_students_path
      return false
    end
    return true
  end

  private
  def semester_is_valid(semester, message="Error: Unable to find the semester for the student.")
    if not semester
      flash[:warning] = [[:semester_id, messsage]]
      redirect_to semesters_path, :method => :get
      return false
    end
    return true
  end
end
