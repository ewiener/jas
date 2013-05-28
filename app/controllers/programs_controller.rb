class ProgramsController < ApplicationController
  protect_from_forgery
  layout "main"
  
  def site_section
  	return @site_section || :programs_section
  end
  
  def home
  	@site_section = :program_home_section
    @program = Program.find(params[:id])
    return unless valid_program?(@program)
    
    if params[:remember_semester] == "true"
    	last_semester = current_user.last_semester_id && Semester.find(current_user.last_semester_id)
    	if last_semester
    		redirect_to home_of_semester_path(last_semester)
    	end
    end
    
    @semesters = @program.semesters.all_by_date
  end
  
  def index
  	if current_user.is_app_admin?
  		# Only the app admin can see all the programs
      @programs = Program.all
   else
	  	# Send everyone else to their program's home
	  	redirect_to home_of_program_path(current_user.program)
	  end	
  end
  
  def show
  	@program = Program.find(params[:id])
  	return unless valid_program?(@program)
  end
  
  def new
  	@program = flash.key?(:program) ? Program.new(flash[:program]) : Program.new
  end
  
  def edit
  	@program = Program.find(params[:id])
  	return unless valid_program?(@program)
  end
  
  def create
    @program = Program.create(params[:program])
    if @program.new_record?
      flash[:warning] = @program.errors
      flash[:program] = params[:program]
      redirect_to new_program_path
    else
      redirect_to programs_path, :notice => "Successfully created #{@program.short_name}."
    end
  end

  def update
    @program = Program.find(params[:id])
    return unless valid_program?(@program)
    
    if @program.update_attributes(params[:program])
      redirect_to program_path, :notice => "#{@program.short_name} was successfully updated."
    else
      flash[:warning] = @program.errors
      redirect_to edit_program_path
    end
  end

  def destroy
    @program = Program.find(params[:id])
    return unless valid_program?(@program) && @program.id != current_user.program.id

    if @program.destroy
      flash[:notice] = "#{@program.short_name} was successfully deleted."
    else
      flash[:warning] = @program.errors
    end

    redirect_to programs_path
  end

end
