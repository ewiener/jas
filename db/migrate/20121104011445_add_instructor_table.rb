class AddInstructorTable < ActiveRecord::Migration
  def up
    create_table 'instructors' do |t|
      t.text       'first_name'
      t.text       'last_name'
      t.text       'email'
      t.text       'phone'
      t.text       'address'
      t.text       'bio'
      t.references 'semester'
      t.timestamps
    end
  end

  def down
    drop_table 'instructors'
  end
end
