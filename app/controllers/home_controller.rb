class HomeController < ApplicationController
	protect_from_forgery
	layout "main"
	
  def site_section
  	:home_section
  end

  def index
  	redirect_to home_of_program_path(current_user.program, :remember_semester => flash[:login])
  end
end
