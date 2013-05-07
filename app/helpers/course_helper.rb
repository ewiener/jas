module CourseHelper	
  def full_mode?
  	params[:full] == 'true'
  end
end