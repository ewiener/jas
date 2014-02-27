class AddDistrictSurchargeToSemester < ActiveRecord::Migration
  def change
    add_column :semesters, :district_surcharge, :float
    add_column :semesters, :registration_fees_waived, :float
    add_column :semesters, :instructor_scholarships, :float
  end
end
