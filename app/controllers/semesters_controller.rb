class SemestersController < ApplicationController
  protect_from_forgery

  def show
    @semester = Semester.find_by_id params[:id]
    return unless semester_is_valid(@semester)
    @courses = @semester.courses
  end

  def index
    #this should show the Jefferson PTA - Sessions home page, listing all semesters, and links to other things
    @semesters = Semester.all.sort_by{|semester| semester.start_date_as_date}.reverse
  end

  def new
    if flash.key? :semester
      @semester = flash[:semester]
      render 'new'
      return
    end
  end

  def create
    @semester = Semester.create(params[:semester])
    if @semester.new_record?
      flash[:warning] = @semester.errors
      flash[:semester] = @semester
      redirect_to new_semester_path
      return
    else
      flash[:notice] = "Successfully created #{@semester.name}."
    end
    redirect_to semesters_path
  end

=begin
  def edit
    @semester = Semester.find_by_id params[:semester_id]
    return unless semester_is_valid(@semester)
  end
=end

  def add_days_off(update_hash)
    name = update_hash[:dates_with_no_classes_name]
    day_span = update_hash[:dates_with_no_classes_day]
    if @semester.dates_in_span_valid?(day_span)
      valid = true
      holiday = Hash[:name => name, :days => day_span]
      update_hash[:dates_with_no_classes] = @semester.dates_with_no_classes
      update_hash[:dates_with_no_classes] +=  [holiday]
      update_hash[:dates_with_no_classes_name] = nil
      update_hash[:dates_with_no_classes_day] = nil
    else
      valid = false
    end
    return update_hash, valid
  end

  def update
    @semester = Semester.find_by_id params[:id]
    return unless semester_is_valid(@semester)
    update_hash = params[:semester]
    if (update_hash.include?(:dates_with_no_classes_name) and update_hash.include?(:dates_with_no_classes_day))
      update_hash, valid = add_days_off(update_hash)
    end
    if valid == false
      flash[:warning] = @semester.errors
      redirect_to semester_path(@semester)
      return
    end
    if @semester.update_attributes(update_hash)
      flash[:notice] = "#{@semester.name} was successfully updated."
      redirect_to semester_path(@semester)
    else
      flash[:warning] = @semester.errors
      redirect_to edit_semester_path
    end
  end

  def destroy
    @semester = Semester.find_by_id params[:id]
    return unless semester_is_valid(@semester)

    name = @semester.name

    if @semester.destroy
      flash[:notice] = "#{name} was successfully deleted."
    else
      flash[:warning] = @semester.errors
    end

    redirect_to semesters_path
  end

  private
  def semester_is_valid(semester)
    if(semester == nil)
      flash[:warning] = [[:id,"Could not find the corresponding semester."]]
      redirect_to semesters_path
      return false
    end
    return true
  end

=begin
  private
  def errors_string(semester)
    error_messages = ""
    semester.errors.each{|attr,msg| error_messages += "#{attr} - #{msg}\n"}
    return error_messages
  end
=end
end

