class SemestersController < ApplicationController
  protect_from_forgery
  layout "main"

  def site_section
  	:semesters_section
  end

  def index
    @semesters = Semester.all.sort_by{|semester| semester.start_date_as_date}.reverse
  end
  
  def show
    @semester = Semester.find(params[:id])
    return unless valid_semester?(@semester)
  end

  def new
    @semester = flash.key?(:semester) ? Semester.new(flash[:semester]) : Semester.new
  end
  
  def edit
    @semester = Semester.find(params[:id])
    return unless valid_semester?(@semester)
    
    @semesters = Semester.all.delete_if{|sem| sem == @semester}.sort_by{|semester| semester.start_date_as_date}.reverse
  end

  def create
    @semester = Semester.create(params[:semester])
    if @semester.new_record?
      flash[:warning] = @semester.errors
      flash[:semester] = params[:semester]
      redirect_to new_semester_path
    else
      redirect_to semesters_path, :notice => "Successfully created #{@semester.name}."
    end
  end

  def add_days_off(update_hash)
  	valid = false
    days_off = update_hash[:dates_with_no_classes_day]
    if @semester.valid_date_span?(days_off)
    	if !@semester.dates_with_no_classes.include?(days_off)
	      update_hash[:dates_with_no_classes] = @semester.dates_with_no_classes
	      update_hash[:dates_with_no_classes] << days_off
	      update_hash[:dates_with_no_classes_day] = nil
	      valid = true
	    else
	    	@semester.errors.add(:base, "Already have holiday #{days_off}")
	    end
    else
    	@semester.errors.add(:base, "Invalid date or date range #{days_off}")
    end
    return update_hash, valid
  end

  def update
    @semester = Semester.find(params[:id])
    return unless valid_semester?(@semester)
    
    update_hash = params[:semester]
    if update_hash.include?(:dates_with_no_classes_day)
      update_hash, valid = add_days_off(update_hash)
	    if !valid
	      flash[:warning] = @semester.errors
	      redirect_to edit_semester_path(@semester)
	      return
	    end
	  end
    if @semester.update_attributes(update_hash)
    	path = params[:keep_editing] ? edit_semester_path : semester_path
      redirect_to path, :notice => "#{@semester.name} was successfully updated."
    else
      flash[:warning] = @semester.errors
      redirect_to edit_semester_path
    end
  end

  def destroy
    @semester = Semester.find(params[:id])
    return unless valid_semester?(@semester)

    if @semester.destroy
      flash[:notice] = "#{@semester.name} was successfully deleted."
    else
      flash[:warning] = @semester.errors
    end

    redirect_to semesters_path
  end

  def import
    @semester = Semester.find(params[:id])
    return unless valid_semester?(@semester)

    if params[:import_semester_id]
      semester_to_import = Semester.find(params[:import_semester_id])
      return unless valid_semester?(semester_to_import, semester_path(@semester), "Invalid import semester")
      if @semester.import(semester_to_import)
        flash[:notice] = "Successfully imported #{semester_to_import.name} into #{@semester.name}"
      else
      	flash[:warning] = @semester.errors
      end
    else
      flash[:warning] = [[:import_semester_id, "The semester id of the semester to import was not found."]]
    end
    redirect_to semester_path(@semester)
  end

  def delete_days_off
    @semester = Semester.find(params[:id])
    return unless valid_semester?(@semester)

    date = params[:date]
    if @semester.delete_date(date)
      flash[:notice] = "Successfully deleted #{date} as a holiday from #{@semester.name}"
    else
      flash[:warning] = @semester.errors
    end
    redirect_to edit_semester_path(@semester)
  end
end

