class TeachersController < ApplicationController
  protect_from_forgery
  layout "main"

  def site_section
  	:teachers_section
  end

  def index
    @semester = Semester.find(params[:semester_id])
    return unless valid_semester?(@semester)
    
    @teachers = @semester.teachers
    @filter = Hash.new
    
    if (params[:filter_active] == 'true')
    	@teachers = @teachers.select{|teacher| teacher.active?}
    	@filter[:active] = 'true'
    elsif (params[:filter_active] == 'false')
    	@teachers = @teachers.select{|teacher| !teacher.active?}
    	@filter[:active] = 'false'
    end
  end

  def show
    @teacher = Teacher.find(params[:id])
    return unless valid_teacher?(@teacher)
    
    @semester = params.include?(:semester_id) ? Semester.find(params[:semester_id]) : @teacher.semester
    return unless valid_semester?(@semester)
  end

  def new
    @semester = Semester.find(params[:semester_id])
    return unless valid_semester?(@semester)
    
    @teacher = flash.key?(:course) ? Teacher.new(flash[:course]) : Teacher.new
  end

  def create
    @semester = Semester.find(params[:semester_id])
    return unless valid_semester?(@semester)

    @teacher = @semester.teachers.create(params[:teacher])
    if not @teacher.new_record?
      redirect_to semester_teachers_path(@semester), :notice => "Successfully added #{@teacher.classroom} to the database."
    else
      flash[:warning] = @teacher.errors
      flash[:teacher] = params[:teacher]
      redirect_to new_semester_teacher_path(@semester)
    end
  end

  def edit
    @teacher = Teacher.find(params[:id])
    return unless valid_teacher?(@teacher)
    
    @semester = params.include?(:semester_id) ? Semester.find(params[:semester_id]) : @teacher.semester
    return unless valid_semester?(@semester)
  end

  def update
    @teacher = Teacher.find(params[:id])
    return unless valid_teacher?(@teacher)
    
    @semester = params.include?(:semester_id) ? Semester.find(params[:semester_id]) : @teacher.semester
    return unless valid_semester?(@semester)

    if @teacher.update_attributes(params[:teacher])
      redirect_to teacher_path(@teacher), :notice => "#{@teacher.classroom}'s entry was successfully updated."
    else
      flash[:warning] = @teacher.errors
      flash[:teacher] = params[:teacher] # Save fields so the user doesn't have to re-enter everything again
      redirect_to edit_teacher_path
    end
  end

  def destroy
    @teacher = Teacher.find(params[:id])
    return unless valid_teacher?(@teacher)

    @semester = params.include?(:semester_id) ? Semester.find(params[:semester_id]) : @teacher.semester
    return unless valid_semester?(@semester)

    if @teacher.destroy
      flash[:notice] = "#{@teacher.classroom} was successfully deleted."
    else
      flash[:warning] = @teacher.errors
    end

    redirect_to semester_teachers_path(@semester)
  end
end
