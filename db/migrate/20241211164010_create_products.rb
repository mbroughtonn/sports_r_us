class CreateProducts < ActiveRecord::Migration[8.0]
  def change
    create_table :products do |t|
      t.string :title
      t.text :description
      t.decimal :price
      t.integer :stock_quantity
      t.string :image
      t.string :category

      t.timestamps
    end
  end
end
