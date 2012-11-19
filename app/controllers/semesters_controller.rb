class SemestersController < ApplicationController
  protect_from_forgery

  def show
    @semester = Semester.find_by_id params[:id]
    return unless semester_is_valid(@semester)
    @semesters = Semester.all.delete_if {|sem| sem == @semester}
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

    puts 'ASDFLAKJSDFLKAJSDLFKAJSDLKFJASDLFJASDFLJAKSDF'
    puts params[:import_form]
    puts params
    puts 'ASDFLAKJSDFLKAJSDLFKAJSDLKFJASDLFJASDFLJAKSDF'
    if params[:import_form]
      puts 'ZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZzz'
      import()
      return
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

  def import
    @semester = Semester.find_by_id params[:semester_id]
    return unless semester_is_valid(@semester)

    if params[:import_semester_id]
      semester_to_import = Semester.find_by_id params[:import_semester_id]
      if semester_to_import
        if @semester.import(semester_to_import)
          flash[:notice] = "Successfully imported #{semester_to_import.name} into #{@semester.name}"
        else
          flash[:warning] = @semester.errors
        end
      else
        flash[:warning] = [[:import_semester_id,"The semeste id of the semester to import did not correspond to any semesters in the database."]]
      end
    else
      flash[:warning] = [[:import_semester_id, "The semester id of the semester to import was not found."]]
    end
    redirect_to semester_path(@semester)
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

