class RenameCourseTotalFee < ActiveRecord::Migration
  def up
    rename_column :courses, :total_fee, :course_fee
  end

  def down
    rename_column :courses, :total_fee, :course_fee
  end
end
