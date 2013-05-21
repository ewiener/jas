class UsersController < ApplicationController
  protect_from_forgery
  layout "main"
  
  def site_section
  	return :users_section
  end
  
  def index
  	@program = Program.find(params[:program_id])
    return unless valid_program?(@program)
    
    @users = @program.users
  end
  
  def show
  	@user = User.find(params[:id])
  	return unless valid_user?(@user)
  end
  
  def new
  	@user = flash.key?(:user) ? User.new(flash[:user]) : User.new
  end
  
  def edit
  	@user = User.find(params[:id])
  	return unless valid_user?(@user)
  end
  
  def create
  	@program = Program.find(params[:program_id])
    return unless valid_program?(@program)

    @user = @program.users.create(params[:user])
    if @user.new_record?
      flash[:warning] = @user.errors
      flash[:user] = params[:user]
      redirect_to new_program_user_path
    else
      redirect_to program_users_path, :notice => "Successfully created #{@user.username}."
    end
  end

  def update
    @user = User.find(params[:id])
    return unless valid_user?(@user)
    
    if params[:user][:password] && params[:user][:password].length == 0
    	params[:user].delete(:password)
    end
    if @user.update_attributes(params[:user])
      redirect_to user_path, :notice => "#{@user.username} was successfully updated."
    else
      flash[:warning] = @user.errors
      redirect_to edit_user_path
    end
  end

  def destroy
    @user = User.find(params[:id])
    return unless valid_user?(@user) && @user.id != current_user.id

    if @user.destroy
      flash[:notice] = "#{@user.username} was successfully deleted."
    else
      flash[:warning] = @user.errors
    end

    redirect_to program_users_path(current_user.program)
  end

end