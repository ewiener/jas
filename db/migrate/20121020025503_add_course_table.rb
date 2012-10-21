class AddCourseTable < ActiveRecord::Migration
  def up
    create_table 'courses' do |t|
      t.text    'name'
      t.text    'description'
      t.text    'days_of_week'
      t.text    'number_of_classes'
      t.text    'start_time'
      t.text    'start_time_type'
      t.text    'end_time'
      t.integer 'class_min'
      t.integer 'class_max'
      t.text    'grade_range'
      t.float   'fee_per_meeting'
      t.float   'fee_for_additional_materials'
      t.float   'total_fee'
      t.references 'semester'
    end
  end

  def down
    drop_table 'courses'
  end
end
