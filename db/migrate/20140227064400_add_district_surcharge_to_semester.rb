class AddDistrictSurchargeToSemester < ActiveRecord::Migration
  def change
    add_column :semesters, :district_surcharge, :double
    add_column :semesters, :registration_fees_waived, :double
    add_column :semesters, :instructor_scholarships, :double
  end
end
