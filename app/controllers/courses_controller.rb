class CoursesController  < ApplicationController
  protect_from_forgery
  layout "main"
  
  def site_section
  	:courses_section
  end

  def index
    @semester = Semester.find(params[:semester_id])
    return unless valid_semester?(@semester)
    
    @courses = @semester.courses
    @course_size = Hash[@courses.map {|course| [course.id, course.students.length]}]
  end
  
  def show
    @course = Course.find(params[:id])
    return unless valid_course?(@course)

    @semester = params.include?(:semester_id) ? Semester.find(params[:semester_id]) : @course.semester
    return unless valid_semester?(@semester)
  end

  def new
    @semester = Semester.find(params[:semester_id])
    return unless valid_semester?(@semester)
    
    @ptainstructors = @semester.ptainstructors
    @teachers = @semester.teachers
    
    @course = flash.key?(:course) ? Course.new(flash[:course]) : Course.new
  end

  def create
    @semester = Semester.find(params[:semester_id])
    return unless valid_semester?(@semester, semester_courses_path)
    
    @course = @semester.courses.create(params[:course])
    if not @course.new_record?
    	redirect_to semester_courses_path, :notice => "Successfully created #{@course.name}."
    else
      flash[:warning] = @course.errors
      flash[:course] = params[:course] # Save fields so the user doesn't have to re-enter everything again
      redirect_to new_semester_course_path
    end
  end

  def edit
    @course = Course.find(params[:id])
    return unless valid_course?(@course)

    @semester = params.include?(:semester_id) ? Semester.find(params[:semester_id]) : @course.semester
    return unless valid_semester?(@semester)

    @ptainstructors = @semester.ptainstructors
    @teachers = @semester.teachers
  end

  def update
    @course = Course.find(params[:id])
    return unless valid_course?(@course)

    @semester = params.include?(:semester_id) ? Semester.find(params[:semester_id]) : @course.semester
    return unless valid_semester?(@semester)
    
    if @course.update_attributes(params[:course])
      redirect_to course_path(@course), :notice => "#{@course.name} in #{@semester.name} was successfully updated."
    else
      flash[:warning] = @course.errors
      flash[:course] = params[:course] # Save fields so the user doesn't have to re-enter everything again
      redirect_to edit_course_path
    end
  end

  def destroy
    @course = Course.find(params[:id])
    return unless valid_course?(@course)

    @semester = params.include?(:semester_id) ? Semester.find(params[:semester_id]) : @course.semester
    return unless valid_semester?(@semester)
    
    if @course.destroy
      flash[:notice] = "#{@course.name} was successfully deleted."
    else
      flash[:warning] = @course.errors
    end
    
    redirect_to semester_courses_path(@semester)
  end

  #Returns the number of times a class meets in a semester. Called from javascript, with a hash of the days of the week that are checked
  def calculate_meetings
    @semester = Semester.find(params[:semester_id])
    return unless valid_semester?(@semester, :no_redirect)
    
    class_meetings = 0
    class_meetings_hash = @semester.specific_days_in_semester
    params.each do |d, value|
      day_of_week = d.to_i
      if value != "checked"; next; end
      if ((1 <= day_of_week) and (day_of_week <= 7))
        class_meetings += class_meetings_hash[day_of_week]
      end
    end
 
    render :json => class_meetings.to_json
  end

  def course_fee
    course = Course.find(params[:id])
    return unless valid_course(course, :no_redirect)
    render :json => course.total_fee.to_json
  end  

end
