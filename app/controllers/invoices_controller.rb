class InvoicesController < ApplicationController
  protect_from_forgery
  layout "main"

  def site_section
    :invoices_section
  end

  def semester_index
    @semester = Semester.find(params[:id])
    return unless valid_semester?(@semester)

    @invoices = @semester.invoices
  end

  def index
    @instructor = Instructor.find(params[:instructor_id])
    return unless valid_instructor?(@instructor)

    @semester = @instructor.semester
    @invoices = @instructor.invoices
  end

  def show
    @invoice = Invoice.find(params[:id])
    return unless valid_invoice?(@invoice)

    @instructor = @invoice.instructor
    @semester = @instructor.semester
  end

  def new
    @instructor = Instructor.find(params[:instructor_id])
    return unless valid_instructor?(@instructor)

    @semester = @instructor.semester

    @invoice = flash.key?(:invoice) ? Invoice.new(flash[:invoice]) : Invoice.new
  end

  def edit
    @invoice = Invoice.find(params[:id])
    return unless valid_invoice?(@invoice)

    @instructor = @invoice.instructor
    @semester = @instructor.semester
  end

  def create
    @instructor = Instructor.find(params[:instructor_id])
    return unless valid_instructor?(@instructor)

    @semester = @instructor.semester

    @invoice = @instructor.invoices.create(params[:invoice])

    if !@invoice.new_record?
      redirect_to instructor_path(@instructor),
          :notice => "#{@invoice.name} invoice was successfully added to the database."
    else
      flash[:warning] = @invoice.errors
      flash[:invoice] = params[:invoice] # Save fields so the user doesn't have to re-enter everything again
      redirect_to instructor_path(@instructor)
    end
  end

  def update
    @invoice = Invoice.find(params[:id])
    return unless valid_invoice?(@invoice)

    @instructor = @invoice.instructor
    @semester = @instructor.semester

    if @invoice.update_attributes(params[:invoice])
      redirect_to instructor_path(@instructor),
          :notice => "#{@invoice.name} invoice was successfully updated."
    else
      flash[:warning] = @invoice.errors
      flash[:invoice] = params[:invoice] # Save fields so the user doesn't have to re-enter everything again
      redirect_to instructor_path(@instructor)
    end
  end

  def destroy
    @invoice = Invoice.find(params[:id])
    return unless valid_invoice?(@invoice)

    @instructor = @invoice.instructor
    @semester = @instructor.semester

    if @invoice.destroy
      flash[:notice] = "#{@invoice.name} invoice was successfully deleted"
    else
      flash[:warning] = @invoice.errors
    end
    redirect_to instructor_path(@instructor)
  end
end
