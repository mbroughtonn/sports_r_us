class ChangeDescriptionNullConstraintOnCategories < ActiveRecord::Migration[6.0]
  def change
    change_column_null :categories, :description, true
  end
end
