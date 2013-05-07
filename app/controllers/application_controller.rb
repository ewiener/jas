class ApplicationController < ActionController::Base
  protect_from_forgery

  helper :all
  helper_method :current_user_session, :current_user, :all_semesters, :site_section

  before_filter :require_user

  private
  def current_user_session
    @current_user_session ||= UserSession.find
  end

  def current_user
    @current_user ||= current_user_session && current_user_session.user
  end
  
  def all_semesters
  	@all_semesters = Semester.all.sort_by{|semester| semester.start_date_as_date}.reverse
  end

  def require_user
    unless current_user
      save_location
      redirect_to login_path
      return false
    end
  end

  def save_location
    session[:return_to] = request.fullpath
  end
    
  def saved_location
  	session[:return_to]
  end

  def clear_saved_location
  	session[:return_to] = nil
  end
    
  def redirect_to_saved_location(default)
    redirect_to saved_location || default
    clear_saved_location
  end
  
  def site_section
  end

  def valid_semester?(semester, redirect_path=:root, message="Could not find the given semester.")
    return true unless semester.nil?
    flash[:warning] = [[:semester_id, message]]
    redirect_to redirect_path unless redirect_path == :no_redirect
    return false
  end
  
  def valid_student?(student, redirect_path=:root, message="Could not find the given student.")
    return true unless student.nil?
    flash[:warning] = [[:student_id,message]]
    redirect_to redirect_path unless redirect_path == :no_redirect
    return false
  end
  
  def valid_ptainstructor?(instructor, redirect_path=:root, message="Could not find the given instructor.")
    return true unless instructor.nil?
    flash[:warning] = [[:ptainstructor_id,message]]
    redirect_to redirect_path unless redirect_path == :no_redirect
    return false
  end
  
  def valid_teacher?(teacher, redirect_path=:root, message="Could not find the given teacher.")
    return true unless teacher.nil?
    flash[:warning] = [[:teacher,message]]
    redirect_to redirect_path unless redirect_path == :no_redirect
    return false
  end

  def valid_course?(course, redirect_path=:root, message="Could not find the given course.")
    return true unless course.nil?
    flash[:warning] = [[:course_id,message]]
    redirect_to redirect_path unless redirect_path == :no_redirect
    return false
  end

  def valid_enrollment?(enrollment, redirect_path=:root, message="Could not find the given enrollment.")
    return true unless enrollment.nil?
    flash[:warning] = [[:enrollment,message]]
    redirect_to redirect_path unless redirect_path == :no_redirect
    return false
  end
end
