#This a shim controller that is used to automatically filter out any user that is not logged in on any controller that requires a logged in user
#Simply inherit from this controller if the controller requires a logged in user
class ValidateLoginController < ApplicationController
#before_filter :set_current_user unless Rails.env.development?
#  protected
#  def set_current_user
#    @current_user ||= Login.find_by_id(session[:user_id])
#    redirect_to  login_path and return unless @current_user
#  end
end
