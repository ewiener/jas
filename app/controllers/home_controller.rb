class HomeController < ApplicationController
	protect_from_forgery
	layout "main"
	
  def site_section
  	:home_section
  end

  def index
  	redirect_to semesters_path
  end
end
