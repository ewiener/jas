class AddPtaInstructorTable < ActiveRecord::Migration
  def up
    create_table 'ptainstructors'
    t.text       'name'
    t.text       'email'
    t.text       'phone'
    t.text       'address'
    t.text       'bio'
  end

  def down
    drop_table 'ptainstructors'
  end
end
