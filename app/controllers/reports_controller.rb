class ReportsController < ApplicationController
  protect_from_forgery
  layout "main"
  
  def site_section
  	:reports_section
  end

  def index
    @semester = Semester.find(params[:semester_id])
    return unless valid_semester?(@semester)
    
    @reports = @semester.reports
  end
  
  def show
    @report = Report.find(params[:id])
    return unless valid_report?(@report)

    @semester = params.include?(:semester_id) ? Semester.find(params[:semester_id]) : @report.semester
    return unless valid_semester?(@semester)
    
    # MyReport gets rendered by reports/my_report
    view = @report.class.name.underscore
    render "reports/#{view}"
  end
end