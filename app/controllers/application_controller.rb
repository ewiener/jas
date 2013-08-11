class ApplicationController < ActionController::Base
  protect_from_forgery

  helper :all
  helper_method :current_user_session, :current_user, :current_program, :all_semesters, :site_section

  before_filter :require_user

  private
  def current_user_session
    @current_user_session ||= UserSession.find
  end

  def current_user
    @current_user ||= current_user_session && current_user_session.user
  end

  def current_program
  	return @program if @program
  	return @semester.program if @semester
  	return @user.program if @user
  	return current_user.program if current_user
  	return nil
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
  
  def redirect_to_saved_location(default = nil)
  	redirect_path = saved_location || default || :root
    redirect_to redirect_path
    clear_saved_location
  end
  
  def site_section
  end

  def valid_program?(program, redirect_path=:root, message="Invalid or inaccessible program.")
    return true if !program.nil? && 
      (current_user.is_app_admin? || 
       program == current_user.program)
    flash[:warning] = [[:program_id, message]]
    redirect_to redirect_path unless redirect_path == :no_redirect
    return false
  end
  
  def valid_user?(user, redirect_path=:root, message="Invalid or inaccessible user.")
    return true if !user.nil? &&
      (current_user.is_app_admin? ||
       user == current_user ||
       (user.program == current_user.program && current_user.is_program_admin?))
    flash[:warning] = [[:user_id, message]]
    redirect_to redirect_path unless redirect_path == :no_redirect
    return false
  end

  def valid_semester?(semester, redirect_path=:root, message="Invalid or inaccessible session.")
    return true if !semester.nil? && 
      (current_user.is_app_admin? || 
       semester.program == current_user.program)
    flash[:warning] = [[:semester_id, message]]
    redirect_to redirect_path unless redirect_path == :no_redirect
    return false
  end
  
  def valid_student?(student, redirect_path=:root, message="Invalid or inaccessible student.")
    return true if !student.nil? && 
      (current_user.is_app_admin? || 
       student.semester.program == current_user.program)
    flash[:warning] = [[:student_id,message]]
    redirect_to redirect_path unless redirect_path == :no_redirect
    return false
  end
  
  def valid_instructor?(instructor, redirect_path=:root, message="Invalid or inaccessible instructor.")
    return true if !instructor.nil? && 
      (current_user.is_app_admin? || 
       instructor.semester.program == current_user.program)
    flash[:warning] = [[:instructor_id,message]]
    redirect_to redirect_path unless redirect_path == :no_redirect
    return false
  end
  
  def valid_classroom?(classroom, redirect_path=:root, message="Invalid or inaccessible classroom.")
    return true if !classroom.nil? &&
      (current_user.is_app_admin? ||
       classroom.semester.program == current_user.program)
    flash[:warning] = [[:classroom,message]]
    redirect_to redirect_path unless redirect_path == :no_redirect
    return false
  end

  def valid_course?(course, redirect_path=:root, message="Invalid or inaccessible class.")
    return true if !course.nil? &&
      (current_user.is_app_admin? ||
       course.semester.program == current_user.program)
    flash[:warning] = [[:course_id,message]]
    redirect_to redirect_path unless redirect_path == :no_redirect
    return false
  end

  def valid_enrollment?(enrollment, redirect_path=:root, message="Invalid or inaccessible enrollment.")
    return true unless enrollment.nil? &&
      (current_user.is_app_admin? ||
       enrollment.semester.program == current_user.program)
    flash[:warning] = [[:enrollment,message]]
    redirect_to redirect_path unless redirect_path == :no_redirect
    return false
  end
  
  def valid_report?(report, redirect_path=:root, message="Invalid or inaccessible report.")
    return true unless report.nil?
    flash[:warning] = [[:report,message]]
    redirect_to redirect_path unless redirect_path == :no_redirect
    return false
  end
end
