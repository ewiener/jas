class PtainstructorsController < ApplicationController
  protect_from_forgery
  def show
    id = params[:id]

  end

  def index
    @ptainstructors = Ptainstructor.all.sort_by{|instructor| instructor.name}.reverse
  end

  def create

  end

  def edit
    id = params[:id]
  end

  def update

  end

  def destroy

  end
end
