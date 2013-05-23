class InstructorsController < ApplicationController
  protect_from_forgery
  layout "main"

  def site_section
  	:instructors_section
  end

  def index
    @semester = Semester.find(params[:semester_id])
    return unless valid_semester?(@semester)

    @instructors = @semester.instructors.by_name
    @filter = Hash.new
    
    if (params[:filter_active] == 'true')
    	@instructors = @instructors.select{|instructor| instructor.has_courses?}
    	@filter[:active] = 'true'
    elsif (params[:filter_active] == 'false')
    	@instructors = @instructors.select{|instructor| !instructor.has_courses?}
    	@filter[:active] = 'false'
    end
  end
  
  def show
    @instructor = Instructor.find(params[:id])
    return unless valid_instructor?(@instructor)
    
    @semester = params.include?(:semester_id) ? Semester.find(params[:semester_id]) : @instructor.semester
    return unless valid_semester?(@semester)
  end

  def new
    @semester = Semester.find(params[:semester_id])
    return unless valid_semester?(@semester)
    
    @instructor = flash.key?(:instructor) ? Instructor.new(flash[:instructor]) : Instructor.new
  end

  def create
    @semester = Semester.find(params[:semester_id])
    return unless valid_semester?(@semester)

    @instructor = @semester.instructors.create(params[:instructor])
    if not @instructor.new_record?
    	redirect_to semester_instructors_path(@semester), 
    	    :notice => "#{@instructor.first_name} #{@instructor.last_name} was successfully added to the database."
    else
      flash[:warning] = @instructor.errors
      flash[:instructor] = params[:instructor] # Save fields so the user doesn't have to re-enter everything again
      redirect_to new_semester_instructor_path
    end
  end

  def edit
    @instructor = Instructor.find(params[:id])
    return unless valid_instructor?(@instructor)
    
    @semester = params.include?(:semester_id) ? Semester.find(params[:semester_id]) : @instructor.semester
    return unless valid_semester?(@semester)
  end

  def update
    @instructor = Instructor.find(params[:id])
    return unless valid_instructor?(@instructor)

    @semester = params.include?(:semester_id) ? Semester.find(params[:semester_id]) : @instructor.semester
    return unless valid_semester?(@semester)

    if @instructor.update_attributes(params[:instructor])
      redirect_to instructor_path(@instructor),
          :notice => "#{@instructor.first_name} #{@instructor.last_name}'s information was successfully updated."
    else
      flash[:warning] = @instructor.errors
      flash[:instructor] = params[:instructor] # Save fields so the user doesn't have to re-enter everything again
      redirect_to edit_instructor_path
    end
  end

  def destroy
    @instructor = Instructor.find_by_id params[:id]
    return unless valid_instructor?(@instructor)

    @semester = params.include?(:semester_id) ? Semester.find(params[:semester_id]) : @instructor.semester
    return unless valid_semester?(@semester)

    if @instructor.destroy
      flash[:notice] = "#{@instructor.first_name} #{@instructor.last_name} was successfully deleted."
    else
      flash[:warning] = @instructor.errors
    end

    redirect_to semester_instructors_path(@semester)
  end
end
