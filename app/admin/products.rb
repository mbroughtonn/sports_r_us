ActiveAdmin.register Product do
  permit_params :name, :description, :price, :category_id, :brand_id, :image

  config.per_page = Product.count

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
