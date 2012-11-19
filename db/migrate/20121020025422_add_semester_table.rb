class AddSemesterTable < ActiveRecord::Migration
  def up
    create_table 'semesters' do |t|
      t.text   'name'
      t.text   'semester_name'
      t.text   'start_date'
      t.text   'end_date'
      t.text   'dates_with_no_classes'
      t.text   'lottery_deadline'
      t.text   'registration_deadline'
      t.float  'fee'
      t.text   'dates_with_no_classes_name'
      t.text   'dates_with_no_classes_day'
      t.text   'individual_dates_with_no_classes'
    end
  end

  def down
    drop_table 'semesters'
  end
end
