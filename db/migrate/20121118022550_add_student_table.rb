class AddStudentTable < ActiveRecord::Migration
  def up
    create_table 'students' do |t|
      t.text        'first_name'
      t.text        'last_name'
      t.text        'grade'
      t.text        'student_phone'
      t.text        'parent_phone'
      t.text        'parent_phone2'
      t.text        'parent_name'
      t.text        'parent_email'
      t.text        'health_alert'
    end
  end

  def down
    drop_table 'students'
  end
end
