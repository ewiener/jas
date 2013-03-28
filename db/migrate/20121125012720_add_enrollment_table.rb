class AddEnrollmentTable < ActiveRecord::Migration
  def up
    create_table 'enrollments' do |t|
      t.integer    'dismissal'
      t.integer    'scholarship'
      t.float      'scholarship_amount'
      t.boolean    'enrolled'
      t.references 'course'
      t.references 'student'
    end
  end

  def down
    drop_table 'enrollments'
  end
end
