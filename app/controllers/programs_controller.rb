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
    
    @semesters = @program.semesters_by_date
  end
  
  def index
  	# Only the super user can see all the programs, but we don't handle that yet
  	# Send everyone else to their program's home
  	redirect_to home_of_program_path(current_user.program)
  end
end
