class AddClassroomTable < ActiveRecord::Migration
  def up
    create_table 'classrooms' do |t|
      t.text    'name'
      t.text    'teacher'
      t.text    'grade'
      t.references 'semester'
      t.timestamps
    end
  end

  def down
    drop_table 'classrooms'
  end
end
