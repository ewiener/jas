class PtainstructorsController < ApplicationController
  protect_from_forgery

  def show
    #Need to check for admin
    @ptainstructor = Ptainstructor.find_by_id params[:id]
    return unless ptainstructor_is_valid(@ptainstructor)

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
    @ptainstructors = Ptainstructor.all
  end

  def new
    @semester = Semester.find_by_id params[:semester_id]
    #@ptainstructor = Ptainstructor.new
  end

  def create
    #check for admin
    @ptainstructor = Ptainstructor.create(params[:ptainstructor])
    #@ptainstructor.update_attributes(params[:ptainstructor])
    if @ptainstructor.new_record?
      flash[:warning] = @ptainstructor.errors
      redirect_to new_semester_ptainstructor_path
      return
    else
      flash[:notice] = "#{@ptainstructor.name} was successfully added to the database."
      redirect_to semester_ptainstructors_path
    end
  end

  def edit
    #check if admin or if not, check to see if the logged in ptainstructor id is the id
    #of the ptainstructor being edited
    @ptainstructor = Ptainstructor.find_by_id params[:id]
    return unless ptainstructor_is_valid(@ptainstructor)
  end

  def update
    #Check if admin or if the current ptainstructor matches the id of the ptainstructor being modified
    @ptainstructor = Ptainstructor.find_by_id params[:id]
    return unless ptainstructor_is_valid(@ptainstructor)

    if @ptainstructor.update_attributes(params[:ptainstructor])
      flash[:notice] = "#{@ptainstructor.name}'s information was successfully updated."
      redirect_to ptainstructors_path
    else
      flash[:warning] = @ptainstructor.errors
      redirect_to edit_ptainstructor_path
    end
  end

  def destroy
    #Check is the ptainstructor is an admin.  Only admin's should be able to delete ptainstructors
    @ptainstructor = Ptainstructor.find_by_id params[:id]
    return unless ptainstructor_is_valid(@ptainstructor)

    name = @ptainstructor.name

    if @ptainstructor.destroy
      flash[:notice] = "#{name} was successfully deleted."
    else
      flash[:warning] = @ptainstructor.errors
    end

    redirect_to ptainstructors_path
  end

  def ptainstructor_is_valid(user)
    if(user == nil)
      flash[:warning] = [[:id, "Could not find the corresponding PTA instructor."]]
      redirect_to ptainstructors_path
      return false
    end
    return true
  end
end

