class SemestersController  < ValidateLoginController
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

  end

  def create
    @semester = Semester.create(params[:semester])
    if @semester.new_record?
      flash[:warning] = @semester.errors
      redirect_to new_semester_path
      return
    else
      flash[:notice] = "Successfully created #{@semester.name}."
    end
    redirect_to semesters_path
  end

  def edit
    @semester = Semester.find params[:semester_id]
    return unless semester_is_valid(@semester)
  end

  def update
    @semester = Semester.find params[:id]
    return unless semester_is_valid(@semester)

    #not sure what to call update_attributes with
    if @semester.update_attributes(params[:semester])
      flash[:notice] = "#{@semester.name} was successfully updated."
      redirect_to semester_path(@semester)
    else
      flash[:warning] = @semester.errors
      redirect_to edit_semester_path
    end
  end

  def destroy
    @semester = Semester.find(params[:id])
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

