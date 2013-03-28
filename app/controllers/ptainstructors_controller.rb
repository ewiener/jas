class PtainstructorsController < ApplicationController
  protect_from_forgery

  def index
    @semester = Semester.find(params[:semester_id])
    return unless valid_semester?(@semester)

    @ptainstructors = @semester.ptainstructors
  end

  def new
    @semester = Semester.find(params[:semester_id])
    return unless valid_semester?(@semester)
    
    @ptainstructor = flash.key?(:ptainstructor) ? Ptainstructor.new(flash[:ptainstructor]) : Ptainstructor.new
  end

  def create
    @semester = Semester.find(params[:semester_id])
    return unless valid_semester?(@semester)

    @ptainstructor = @semester.ptainstructors.create(params[:ptainstructor])
    if not @ptainstructor.new_record?
    	redirect_to semester_ptainstructors_path(@semester), 
    	    :notice => "#{@ptainstructor.first_name} #{@ptainstructor.last_name} was successfully added to the database."
    else
      flash[:warning] = @ptainstructor.errors
      flash[:ptainstructor] = params[:ptainstructor] # Save fields so the user doesn't have to re-enter everything again
      redirect_to new_semester_ptainstructor_path
    end
  end

  def edit
    @ptainstructor = Ptainstructor.find(params[:id])
    return unless valid_ptainstructor?(@ptainstructor)
    
    @semester = params.include?(:semester_id) ? Semester.find(params[:semester_id]) : @ptainstructor.semester
    return unless valid_semester?(@semester)
  end

  def update
    @ptainstructor = Ptainstructor.find(params[:id])
    return unless valid_ptainstructor?(@ptainstructor)

    @semester = params.include?(:semester_id) ? Semester.find(params[:semester_id]) : @ptainstructor.semester
    return unless valid_semester?(@semester)

    if @ptainstructor.update_attributes(params[:ptainstructor])
      redirect_to semester_ptainstructors_path(@semester),
          :notice => "#{@ptainstructor.first_name} #{@ptainstructor.last_name}'s information was successfully updated."
    else
      flash[:warning] = @ptainstructor.errors
      flash[:ptainstructor] = params[:ptainstructor] # Save fields so the user doesn't have to re-enter everything again
      redirect_to edit_ptainstructor_path
    end
  end

  def destroy
    @ptainstructor = Ptainstructor.find_by_id params[:id]
    return unless valid_ptainstructor?(@ptainstructor)

    @semester = params.include?(:semester_id) ? Semester.find(params[:semester_id]) : @ptainstructor.semester
    return unless valid_semester?(@semester)

    if @ptainstructor.destroy
      flash[:notice] = "#{@ptainstructor.first_name} #{@ptainstructor.last_name} was successfully deleted."
    else
      flash[:warning] = @ptainstructor.errors
    end

    redirect_to semester_ptainstructors_path(@semester)
  end
end
