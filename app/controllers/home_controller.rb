class HomeController < ApplicationController
  def index
  	redirect_to semesters_path
  end
end
