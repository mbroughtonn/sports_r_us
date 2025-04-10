ActiveAdmin.register Product do
  # Permitted parameters for product creation and updates
  permit_params :name, :description, :price, :category_id, :brand_id, :image

  # Disable pagination to show all products
  config.per_page = Product.count  # Display all products

  # Example: Configure the index view
  index do
    selectable_column
    id_column
    column :name
    column :description
    column :price
    column :category
    column :brand
    actions
  end

  # Example: Configure the form view for new and edit actions
  form do |f|
    f.inputs "Product Details" do
      f.input :name
      f.input :description
      f.input :price
      f.input :category
      f.input :brand
      f.input :image, as: :file
    end
    f.actions
  end
end
