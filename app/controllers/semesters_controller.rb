class SemestersController  < ValidateLoginController

  protect_from_forgery

  def show
    @semester = Semester.find params[:id]
  end

  def index
    #this should show the Jefferson PTA - Sessions home page, listing all semesters, and links to other things
    @semesters = Semester.all
  end

  def new

  end

  def create
    puts params[:semester]
    @semester = Semester.create!(params[:semester])
    if @semester.new_record?
      flash[:warning] = "Could not create the semester.  Encountered the following errors:\n" + errors_string(@semester)
      render "new"
      return
    else
      flash[:notice] = "#{@semester.name} was successfully created."
    end
    puts @semester.name
    redirect_to :semesters
  end

  def edit
    @semester = Semester.find params[:semester_id]
    if semester_is_nil @semester
      redirect_to :semesters
      return
    end
  end

  def update
    @semester = Semester.find params[:semester_id]
    if semester_is_nil @semester
      redirect_to :semesters
      return
    end
    #not sure what to call update_attributes with
    if @semester.update_attributes(params[:semester])
      flash[:notice] = "#{@semester.name} was successfully updated."
      redirect_to :semesters
    else
      flash[:warning] = "{@semester.name} could not be updated.  The following errors occured:\n"  + errors_string(@semester)
      render 'edit'
    end
  end

  def destroy
    @semester = Semester.find(params[:semester_id])
    if semester_is_nil @semester
      redirect_to :semesters
      return
    end
    name = @semester.name
    if @semester.destroy
      flash[:notice] = "#{name} was successfully deleted."
    else
      flash[:warning] = "#{name} was not successfully deleted. The following errors occured:\n" + errors_string(@semester)
    end
    redirect_to :semesters
  end

  private
  def semester_is_nil(semester)
    if(semester == nil)
      flash[:warning] = "Could not find the corresponding semester."
      return true
    end
    return false
  end

  private
  def errors_string(semester)
    error_messages = ""
    semester.errors.each{|attr,msg| error_messages += "#{attr} - #{msg}\n"}
    return error_messages
  end
end
