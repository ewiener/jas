class CreateInvoices < ActiveRecord::Migration
  def change
    create_table :invoices do |t|
      t.references :instructor
      t.string :name
      t.float :amount
      t.string :submitted_at
      t.text :notes

      t.timestamps
    end
  end
end
