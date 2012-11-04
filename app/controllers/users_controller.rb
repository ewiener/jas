class UsersController < ApplicationController
  protect_from_forgery

  def show
    #Need to check for admin
    @user = User.find_by_id params[:id]
    return unless user_is_valid(@user)

  end

  def index
    @users = User.all
  end

  def new
    #@user = User.new
  end

  def create
    #check for admin
    @user = User.create(params[:user])
    #@user.update_attributes(params[:user])
    if @user.new_record?
      flash[:warning] = @user.errors
      redirect_to new_user_path
      return
    else
      flash[:notice] = "#{@user.name} was successfully added to the database."
    end
    redirect_to users_path
  end

  def edit
    #check if admin or if not, check to see if the logged in user id is the id
    #of the user being edited
    @user = User.find_by_id params[:id]
    return unless user_is_valid(@user)
  end

  def update
    #Check if admin or if the current user matches the id of the user being modified
    @user = User.find_by_id params[:id]
    return unless user_is_valid(@user)

    if @user.update_attributes(params[:user])
      flash[:notice] = "#{@user.name}'s information was successfully updated."
      redirect_to users_path
    else
      flash[:warning] = @user.errors
      redirect_to edit_user_path
    end
  end

  def destroy
    #Check is the user is an admin.  Only admin's should be able to delete users
    @user = User.find_by_id params[:id]
    return unless user_is_valid(@user)

    name = @user.name

    if @user.destroy
      flash[:notice] = "#{name} was successfully deleted."
    else
      flash[:warning] = @user.errors
    end

    redirect_to users_path
  end
=begin
     def create
       @user = User.new(params[:user])
       if @user.save
         session[:user_id] = @user.id
         flash[:notice] = "Thanks for signing up! You are now logged in."
         redirect_to root_url
       else
         render :action => 'new'
       end
     end
=end
  def user_is_valid(user)
    if(user == nil)
      flash[:warning] = [[:id, "Could not find the corresponding user."]]
      redirect_to users_path
      return false
    end
    return true
  end
end

