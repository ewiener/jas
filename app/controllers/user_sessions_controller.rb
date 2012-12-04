class UserSessionsController < ApplicationController
  #before_filter :require_no_user, :only => [:new, :create]
  #before_filter :require_user, :only => :destroy
  skip_before_filter :require_user, :only => [:new, :create]

  def new
    redirect_to semesters_path unless not ((current_user_session) and (current_user_session.user)) # second clause, current_user_session.user, required to detect timeouts for the sessions
    @user_session = UserSession.new
  end

  def create
    @user_session = UserSession.new(params[:user_session])
    if @user_session.save
      flash[:notice] = "Successfully logged in as #{@user_session.username}"
      redirect_back_or_default(semesters_path)
    else
      flash[:warning] = "Failed to login using the given credentials."
      redirect_to :root
    end
  end

  def destroy
    current_user_session.destroy
    flash[:notice] = "Logout successful!"
    redirect_to :root
  end
end
