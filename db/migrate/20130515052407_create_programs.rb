class CreatePrograms < ActiveRecord::Migration
  def change
    create_table :programs do |t|
      t.text :short_name
      t.text :long_name
      t.text :abbrev
      t.text :description
      t.timestamps
    end
  end
end
