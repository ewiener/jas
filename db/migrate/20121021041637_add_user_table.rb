class AddUserTable < ActiveRecord::Migration
  def up
    create_table 'users' do |t|
      t.timestamps
      t.string  :username, :null => false
      t.string :crypted_password, :null => false
      t.string :password_salt, :null => false
      t.string :persistence_token, :null => false
      t.integer :login_count, :default => 0, :null => false
      t.datetime :last_request_at
      t.datetime :last_login_at
      t.datetime :current_login_at
      t.string :last_login_ip
      t.string :current_login_ip
      #t.text    'name'
      #t.text    'email'
      #t.text    'phone'
      #t.text    'address'
      #t.text    'bio'
      #t.text    'password_hash'
      #t.text    'password_salt'
      #t.integer 'type'
    end

    add_index :users, :username
    add_index :users, :persistence_token
    add_index :users, :last_request_at
  end

  def down
    drop_table 'users'
  end
end
