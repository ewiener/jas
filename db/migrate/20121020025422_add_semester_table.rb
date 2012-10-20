class AddSemesterTable < ActiveRecord::Migration
  def up
    create_table 'semesters' do |t|
      t.text   'name'
      t.text   'start_date'
      t.text   'end_date'
      t.text   'dates_with_no_classes'
      t.text   'lottery_deadline'
      t.text   'registration_deadline'
    end
  end

  def down
    drop_table 'semesters'
  end
end
