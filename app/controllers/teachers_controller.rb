class TeachersController < ApplicationController
  protect_from_forgery

  def show
    @teacher = Teacher.find_by_id params[:id]
    return unless teacher_is_valid(@teacher)
  end

  def index
    if params[:semester_id]
      @semester = Semester.find_by_id params[:semester_id]
      if not @semester
        flash[:warning] = "Unable to locate the specified semester."
        redirect_to semester_index
        return
      end
      @teachers = Teacher.all
    else
      flash[:warning] = "No semester was associated with the teachers."
      redirect_to semester_index
      return
    end
  end

  def new
    @semester = Semester.find_by_id params[:semester_id]
    return unless semester_is_valid(@semester)
    if flash.key? :course
      @course = flash[:course]
      render 'new'
      return
    end
  end

  def create
    @semester = Semester.find_by_id params[:semester_id]
    return unless semester_is_valid(@semester,"Error: Unable to find a semester to associated with the teacher.")

    @teacher = @semester.teachers.create(params[:teacher])
    if @teacher.new_record?
      flash[:warning] = @teacher.errors
      flash[:teacher] = @teacher
      redirect_to new_semester_teacher_path(@semester)
      return
    else
      flash[:notice] = "Successfully added #{@teacher.name} to the database."
      redirect_to semester_teachers_path(@semester)
    end
  end

  def edit
    @teacher = Teacher.find_by_id params[:id]
    return unless teacher_is_valid(@teacher)
  end

  def update
    @teacher = Teacher.find_by_id params[:id]
    return unless teacher_is_valid(@teacher)

    if @teacher.update_attributes(params[:id])
      flash[:notice] = "#{teacher.name}'s entry was successfully updated."
      redirect_to teacher_path(@teacher)
    else
      flash[:warning] = @teacher.errors
      redirect_to edit_teacher_path(@teacher)
    end
  end

  def destroy
    @teacher = Teacher.find_by_id
    return unless teacher_is_valid(@teacher)

    name = @teacher.name

    if @teacher.destroy
      flash[:notice] = "#{name} was successfully deleted from the database."
    else
      flash[:warning] = @teacher.errors
    end

    redirect_to teachers_path
  end

  private
  def teacher_is_valid(teacher)
    if(teacher == nil)
      flash[:warning] = [[:id, "Could not find the corresponding teacher."]]
      redirect_to teachers_path
      return false
    end
    return true
  end


  private
  def semester_is_valid(semester, message="Error: Unable to find the semester for the course.")
    if not semester
      flash[:warning] = [[:semester_id, message]]
      redirect_to semesters_path, :method => :get
      return false
    end
    return true
  end

end
