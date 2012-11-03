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
=begin
      t.integer    'start_time_hour'
      t.integer    'start_time_minute'
      t.integer    'start_time_type'
      t.integer    'end_time_hour'
      t.integer    'end_time_minute'
      t.integer    'end_time_type'
=end
      t.text       'grade_range'
      t.integer    'class_min'
      t.integer    'class_max'
      t.integer    'number_of_classes'
      t.float      'fee_per_meeting'
      t.float      'fee_for_additional_materials'
      t.float      'total_fee'
      t.references 'semester'
    end
  end

  def down
    drop_table 'courses'
  end
end
