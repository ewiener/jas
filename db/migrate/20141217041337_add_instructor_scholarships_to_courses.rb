class AddInstructorScholarshipsToCourses < ActiveRecord::Migration
  def change
    add_column :courses, :instructor_scholarships, :integer
  end
end
