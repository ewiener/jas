class TeachersController < ApplicationController
  protect_from_forgery

  def show
    @teacher = Teacher.find_by_id params[:id]
    return unless teacher_is_valid(@teacher)
  end

  def index
    @teachers = Teacher.all
  end

  def new

  end

  def create
    @teacher = Teacher.create(params[:teacher])
    if @teacher.new_record?
      flash[:warning] = @teacher.errors
      redirect_to new_teacher_path(@teacher)
      return
    else
      flash[:notice] = "Successfully added #{@teacher.name} to the database."
    end
  end

  def edit
    @teacher = Teacher.find_by_id params[:id]
    return unless tecaher_is_valid(@teacher)
  end

  def update
    @teacher = Teacher.find_by_id params[:id]
    return unless teacher_is_valid(@teacher)

    if @teacher.update_attributes(params[:id])
      flash[:notice] = "#{teacher.name}'s entry was successfully updated."
      redirect_to teacher_path(@teacher)
    else
      flash[:warning] = @teacher.errors
      redirect_to edit_teacher_path(@teacher)
    end
  end

  def destroy
    @teacher = Teacher.find_by_id
    return unless teacher_is_valid(@teacher)

    name = @teacher.name

    if @teacher.destroy
      flash[:notice] = "#{name} was successfully deleted from the database."
    else
      flash[:warning] = @teacher.errors
    end

    redirect_to teachers_path
  end


  def teacher_is_valid(teacher)
    if(teacher == nil)
      flash[:warning] = [[:id, "Could not find the corresponding teacher."]]
      redirect_to teachers_path
      return false
    end
    return true
  end
end
