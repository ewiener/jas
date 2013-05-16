class AddCourseTable < ActiveRecord::Migration
  def up
    create_table 'courses' do |t|
      t.text       'name'
      t.text       'description'
      t.boolean    'sunday'
      t.boolean    'monday'
      t.boolean    'tuesday'
      t.boolean    'wednesday'
      t.boolean    'thursday'
      t.boolean    'friday'
      t.boolean    'saturday'
      t.text       'start_time'
      t.text       'end_time'
      t.text       'grade_range'
      t.integer    'class_min'
      t.integer    'class_max'
      t.float      'fee_per_meeting'
      t.float      'fee_for_additional_materials'
      t.float      'course_fee'
      t.references 'semester'
      t.references 'instructor'
      t.references 'classroom'
      t.timestamps
    end
  end

  def down
    drop_table 'courses'
  end
end
