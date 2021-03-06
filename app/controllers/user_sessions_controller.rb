class UserSessionsController < ApplicationController
  skip_before_filter :require_user, :only => [:new, :create]
  layout "headerless"

  def new
    if current_user
    	redirect_to :root
    else
      @user_session = UserSession.new
    end
  end

  def create
    @user_session = UserSession.new(params[:user_session])
    if @user_session.save
      flash[:notice] = "Successfully logged in as #{@user_session.username}"
      flash[:login] = true  # Flags that we came from login so we can jump to saved semester for user if target is root
      redirect_to_saved_location(:root)
    else
      flash[:warning] = "Invalid username or password."
      redirect_to login_path
    end
  end

  def destroy
    current_user_session.destroy
    flash[:notice] = "Logout successful!"
    redirect_to :root
  end
end
