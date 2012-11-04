class AddTeacherTable < ActiveRecord::Migration
  def up
    create_table 'teachers' do |t|
      t.text    'name'
      t.text    'grade'
      t.text    'classroom'
      t.references 'semester'
    end
  end

  def down
    drop_table 'teachers'
  end
end
