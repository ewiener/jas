class CoursesController  < ApplicationController
  protect_from_forgery
=begin
  def show
    @course = Course.find_by_id params[:course_id]
    if not @course
      flash[:warning] = @course.errors
      redirect_to semesters_path
    end
  end
=end
  def index
    @semester = Semester.find_by_id params[:semester_id]
    return unless semester_is_valid(@semester)
    @courses = @semester.courses
    @enrollmentHash = {}
    @courses.each do |course|
      @enrollmentHash[course.id] = course.students.length
    end
  end

  def new
    @semester = Semester.find_by_id params[:semester_id]
    return unless semester_is_valid(@semester)
    @ptainstructors = Ptainstructor.where( :semester_id => @semester )
    @teachers = Teacher.where( :semester_id => @semester )
    if flash.key? :course
      @course = flash[:course]
      render 'new'
      return
    end
  end

  def coursefee
    course = Course.find(params[:id])
    @coursefee = course.total_fee.to_json
    return
  end

  def create
    @semester = Semester.find_by_id params[:semester_id]
    return unless semester_is_valid(@semester,"Error: Unable to find a semester to associated with the class.")
    #special_time_parsing_helper
    params[:course][:ptainstructor] = Ptainstructor.find_by_id params[:course][:ptainstructor]
    params[:course][:teacher] = Teacher.find_by_id params[:course][:teacher]
    @course = @semester.courses.create(params[:course])
    if @course.new_record?
      flash[:warning] = @course.errors
      flash[:course] = @course
      redirect_to new_semester_course_path
      return
    end
    flash[:notice] = "Successfully created #{@course.name}."
    redirect_to semester_courses_path(@semester)
  end

  def edit
    @semester = Semester.find_by_id params[:semester_id]
    return unless semester_is_valid(@semester)
    @course = Course.find_by_id params[:id]
    if not @course
      flash[:warning] = [[:id, "Unable to locate the course given for modification."]]
      redirect_to semester_courses_path
      return
    end
    @ptainstructors = Ptainstructor.find_all_by_semester_id @semester
    @teachers = Teacher.find_all_by_semester_id @semester
    if flash.key? :course
      @course = flash[:course]
      render 'edit'
      return
    end
  end

  def destroy
    @semester = Semester.find_by_id params[:semester_id]
    return unless semester_is_valid(@semester)
    @course = Course.find_by_id params[:id]
    if not @course
      flash[:warning] = [[:id,"Could not find the course to be destroyed."]]
      redirect_to semester_courses_path(@semester)
      return
    end
    course_name = @course.name
    if @course.destroy
      flash[:notice] = "#{course_name} was successfully removed from the database."
    else
      flash[:warning] = @course.errors
    end
    redirect_to semester_courses_path(@semester)
  end

  def update
    @semester = Semester.find_by_id params[:semester_id]
    return unless semester_is_valid(@semester)

    @course = Course.find_by_id params[:id]
    if not @course
      flash[:warning] = [[:id, "The given course for updating could not be found."]]
      redirect_to semester_courses_path(@semester)
      return
    end
    params[:course][:ptainstructor] = Ptainstructor.find_by_id params[:course][:ptainstructor]
    params[:course][:teacher] = Teacher.find_by_id params[:course][:teacher]
    #not sure what to call update_attributes with
    if @course.update_attributes(params[:course])
      if params[:course].length > 0
          flash[:notice] = "#{@course.name} in #{@semester.name} was successfully updated."
      end
      redirect_to semester_courses_path(@semester)
    else
      flash[:warning] = @course.errors
      flash[:course] = @course
      redirect_to edit_semester_course_path
    end
  end
  
  public
  def calculate_meetings
    @semester = Semester.find_by_id params[:semester_id]
    return unless semester_is_valid(@semester)
    class_meetings = 0
    class_meetings_hash = @semester.specific_days_in_semester
    params.each do |d, value|
      puts "before", value
      day_of_week = d.to_i
      if value != "true"; next; end
      if ((1 <= day_of_week) and (day_of_week <= 7))
        class_meetings += class_meetings_hash[day_of_week]
      end
    end
    
    @calculate_meetings = class_meetings.to_json
    render :text => @calculate_meetings
  end
  
  public
  def calculate_total_fees
    per_meeting_cost = params["per_meeting_cost"].to_i
    number_of_meetings = params["meeting_number"].to_i
    additional_fees = params["additional_fees"].to_i
    
    @total_fee = per_meeting_cost*number_of_meetings + additional_fees
    render :text => @total_fee
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
