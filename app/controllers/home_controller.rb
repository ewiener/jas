class HomeController < ApplicationController
	protect_from_forgery
	layout "main"
	
  def site_section
  	:home_section
  end

  def index
  	redirect_to program_semesters_path(current_user.program)
  end
end
