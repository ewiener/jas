class CoursesController  < ValidateLoginController
  protect_from_forgery
  def show
    @course = Course.find params[:course_id]
    if not @course
      flash[:warning] = "Could not find the corresponding course due to the following errors:\n" + errors_string(@course)
      redirect_to semester_index
    end
  end

  def index
    #redirect to the semester homepage
    if params[:semester_id]
      redirect_to semester_path( params[:semester_id] )# semester page
    else
      redirect_to semester_index
    end
  end

  def new
    @semester = Semester.find params[:semester_id]
  end

  def create
    @semester = Semester.find params[:semester_id]
    puts params[:course]
    return unless semester_is_valid(@semester,"Error: Unable to find a semester to associated with the class.")
    @course = @semester.courses.create(params[:course])
    if @course.new_record?
      flash[:warning] =  "Error: Unable to create a new course due to the following errors:\n" + errors_string(@course)
      render "new"
      return
    end
    flash[:notice] = "Successfully created #{@course.name}."
    redirect_to semester_path( @semester.id )
  end

  def edit
    @semester = Semester.find params[:semester_id]
    return unless semester_is_valid(@semester)
    @course = Course.find params[:course_id]
    if not @course
      flash[:warning] = "Error: Unable to locate the course given for modification."
      redirect_to semester_path(@semester.id)
      return
    end
  end
=begin
  def update
    @semester = Semester.find params[:semester_id]
    return unless semester_is_valid(@semester)

    @course = Course.find params[:course_id]
    if not @course
      flash[:warning] = "Error: The given course for updating could not be found."
      redirect_to semester_path( @semester.id )
      return
    end

    #not sure what to call update_attributes with
    if @course.update_attributes(params[:course_id]) then
      flash[:notice] = "#{@course.name} #{@semester.name} was successfully updated."
      redirect_to semester_path( @semester.id )
    else
      flash[:warning] = "#{@course.name} could not be updated because of the following errors:\n" + errors_string(course)
      render 'edit'
    end
  end
=end
=begin
  def destroy
    @course = Course.find(params[:course_id])
    if not @course
      flash[:warning] = "Error: Could not find the course to be destroyed."
      redirect_to semester_index
      return
    end
    course_name = @course.name
    if @course.destroy
      flash[:notice] = "#{course_name} was successfully removed from the database."
    else
      flash[:warning] = "#{course_name} could not be removed from the database beause of the following errors:\n" + errors_string(@course)
    end
    redirect_to semester_index #semester page
  end
=end
  private
  def errors_string(course)
    error_messages = ""
    course.errors.each{|attr,msg| error_messages += "#{attr} - #{msg}\n"}
    return error_messages
  end

  private
  def semester_is_valid(semester, message="Error: Unable to find the semester for the course.")
    if not semester
      flash[:warning] = message
      redirect_to semester_index
      return false
    end
    return true
  end


end
