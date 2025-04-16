class CreateCustomers < ActiveRecord::Migration[8.0]
  def change
    create_table :customers do |t|
      t.string :name
      t.string :email
      t.text :address
      t.string :province

      t.timestamps
    end
  end
end
