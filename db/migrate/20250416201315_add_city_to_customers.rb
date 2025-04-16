class AddCityToCustomers < ActiveRecord::Migration[8.0]
  def change
    add_column :customers, :city, :string
  end
end
