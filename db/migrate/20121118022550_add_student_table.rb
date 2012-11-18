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
      #t.references  'semester'
      #t.references  'teacher'
      #t.
    end
    #create_table 'ptainstructors_students', :id =>false do |t|
    #  t.integer :ptainstructor_id
    #  t.integer :student_id
    #end
    create_table 'courses_students', :id=>false do |t|
      t.integer :course_id
      t.integer :student_id
    end
  end

  def down
    drop_table 'students'
    #drop_table 'ptainstructors_students'
    drop_table 'courses_students'
  end
end
