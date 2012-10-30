class AddUserTable < ActiveRecord::Migration
  def up
    create_table 'users' do |t|
      t.text    'username'
      t.text    'name'
      t.text    'email'
      t.text    'phone'
      t.text    'address'
      t.text    'bio'
      t.text    'password_hash'
      t.text    'password_salt'
      t.integer 'type'
    end
  end

  def down
    drop_table 'users'
  end
end
