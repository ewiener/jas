class CoursesController  < ValidateLoginController
  protect_from_forgery
  def show
    @course = Course.find params[:course_id]
  end

  def index
    #redirect to the semester homepage
    @semester = Semester.find params[:semester_id]
    redirect_to # semester page
  end
  
  def new
    @course = Course.new
    @semester = Semester.find params[:semester_id]
  end

  def create
    @course = Course.new(params[:course_id])
    @semester = Semester.find params[:semester_id]
  end

  def edit
    @course = Course.find params[:course_id]
    @semester = Semester.find params[:semester_id]
  end

  def update
    @course = Course.find params[:course_id]
    @semester = Semester.find params[:semester_id]
    #not sure what to call update_attributes with
    @course.update_attributes!(params[:course_id])
    flash[:notice] = "#{@course.name} #{@semester.name} was successfully updated."
    redirect_to #semester page
  end

  def destroy
    @course = Course.find(params[:course_id])
    @course.destroy
    redirect_to #semester page
  end
end
