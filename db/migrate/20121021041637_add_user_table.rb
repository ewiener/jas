class AddUserTable < ActiveRecord::Migration
  def up
    create_table 'users' do |t|
      t.text    'username'
      t.text    'email'
      t.text    'password'
    end
  end

  def down
    drop_table 'users'
  end
end
