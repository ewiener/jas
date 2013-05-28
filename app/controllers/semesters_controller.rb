class SemestersController < ApplicationController
  protect_from_forgery
  layout "main"
  
  def site_section
  	return @site_section || :semesters_section
  end
  
  def home
  	@site_section = :semester_home_section
    @semester = Semester.find(params[:id])
    return unless valid_semester?(@semester)
    
    # Save last semester in user
    remember_semester
  end
  
  def switch
    @semester = Semester.find(params[:id])
    return unless valid_semester?(@semester)
    
    # Save last semester in user
    remember_semester
    
    if params[:url]
    	redirect_to params[:url]
    else
    	redirect_to home_of_semester_path(@semester)
    end
  end  	

  def index
  	@program = Program.find(params[:program_id])
    return unless valid_program?(@program)
    
    @semesters = @program.semesters.all_by_date
  end
  
  def show
    @semester = Semester.find(params[:id])
    return unless valid_semester?(@semester)
  end

  def new
  	@program = Program.find(params[:program_id])
    return unless valid_program?(@program)
    
    @semester = flash.key?(:semester) ? Semester.new(flash[:semester]) : Semester.new
  end
  
  def edit
    @semester = Semester.find(params[:id])
    return unless valid_semester?(@semester)
    
    @semesters = Semester.all.delete_if{|sem| sem == @semester}.sort_by{|semester| semester.start_date_as_date}.reverse
  end

  def create
  	@program = Program.find(params[:program_id])
    return unless valid_program?(@program)

    @semester = @program.semesters.create(params[:semester])
    if @semester.new_record?
      flash[:warning] = @semester.errors
      flash[:semester] = params[:semester]
      redirect_to new_program_semester_path
    else
      redirect_to program_semesters_path, :notice => "Successfully created #{@semester.name}."
    end
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

    redirect_to program_semesters_path(current_user.program)
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
  
  def scholarship_report
    @semester = Semester.find(params[:id])
    return unless valid_semester?(@semester)

    @scholarship_report = ScholarshipReport.new(@semester)
    render 'reports/scholarship_report'
  end
  
  private
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
  
  def remember_semester
    user = current_user
    if user
      user.last_semester_id = @semester.id
      user.save
    end
  end
end

