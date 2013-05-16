class ClassroomsController < ApplicationController
  protect_from_forgery
  layout "main"

  def site_section
  	:classrooms_section
  end

  def index
    @semester = Semester.find(params[:semester_id])
    return unless valid_semester?(@semester)
    
    @classrooms = @semester.classrooms
    @filter = Hash.new
    
    if (params[:filter_active] == 'true')
    	@classrooms = @classrooms.select{|classroom| classroom.active?}
    	@filter[:active] = 'true'
    elsif (params[:filter_active] == 'false')
    	@classrooms = @classrooms.select{|classroom| !classroom.active?}
    	@filter[:active] = 'false'
    end
  end

  def show
    @classroom = Classroom.find(params[:id])
    return unless valid_classroom?(@classroom)
    
    @semester = params.include?(:semester_id) ? Semester.find(params[:semester_id]) : @classroom.semester
    return unless valid_semester?(@semester)
  end

  def new
    @semester = Semester.find(params[:semester_id])
    return unless valid_semester?(@semester)
    
    @classroom = flash.key?(:course) ? Classroom.new(flash[:course]) : Classroom.new
  end

  def create
    @semester = Semester.find(params[:semester_id])
    return unless valid_semester?(@semester)

    @classroom = @semester.classrooms.create(params[:classroom])
    if not @classroom.new_record?
      redirect_to semester_classrooms_path(@semester), :notice => "Successfully added #{@classroom.name} to the database."
    else
      flash[:warning] = @classroom.errors
      flash[:classroom] = params[:classroom]
      redirect_to new_semester_classroom_path(@semester)
    end
  end

  def edit
    @classroom = Classroom.find(params[:id])
    return unless valid_classroom?(@classroom)
    
    @semester = params.include?(:semester_id) ? Semester.find(params[:semester_id]) : @classroom.semester
    return unless valid_semester?(@semester)
  end

  def update
    @classroom = Classroom.find(params[:id])
    return unless valid_classroom?(@classroom)
    
    @semester = params.include?(:semester_id) ? Semester.find(params[:semester_id]) : @classroom.semester
    return unless valid_semester?(@semester)

    if @classroom.update_attributes(params[:classroom])
      redirect_to classroom_path(@classroom), :notice => "#{@classroom.name}'s entry was successfully updated."
    else
      flash[:warning] = @classroom.errors
      flash[:classroom] = params[:classroom] # Save fields so the user doesn't have to re-enter everything again
      redirect_to edit_classroom_path
    end
  end

  def destroy
    @classroom = Classroom.find(params[:id])
    return unless valid_classroom?(@classroom)

    @semester = params.include?(:semester_id) ? Semester.find(params[:semester_id]) : @classroom.semester
    return unless valid_semester?(@semester)

    if @classroom.destroy
      flash[:notice] = "#{@classroom.name} was successfully deleted."
    else
      flash[:warning] = @classroom.errors
    end

    redirect_to semester_classrooms_path(@semester)
  end
end
