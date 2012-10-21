class SemestersController  < ValidateLoginController

  protect_from_forgery

  def show
    @semester = Semester.find params[:semester_id]
  end

  def index
    #this should show the Jefferson PTA - Sessions home page, listing all semesters, and links to other things
    @semesters = Semester.all
  end

  def new

  end

  def create
    @semester = Semester.create!(params[:semester_id])
    redirect_to index
  end

  def edit
    @semester = Semester.find params[:semester_id]
  end

  def update
    @semester = Semester.find params[:semester_id]
    #not sure what to call update_attributes with
    @semester.update_attributes!(params[:semester])
    flash[:notice] = "#{@semester.name} was successfully updated."
    redirect_to index
  end

  def destroy
    @semester = Semester.find(params[:semester_id])
    @semester.destroy
    redirect_to index
  end
end
