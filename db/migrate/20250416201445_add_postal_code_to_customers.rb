class AddPostalCodeToCustomers < ActiveRecord::Migration[8.0]
  def change
    add_column :customers, :postal_code, :string
  end
end
