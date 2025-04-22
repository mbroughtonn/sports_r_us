ActiveAdmin.register Product do
  permit_params :name, :description, :price, :stock_quantity, :category_id, :brand_id, :image

  filter :category, as: :select, collection: Category.all.pluck(:name, :id)
  filter :brand, as: :select, collection: Brand.all.pluck(:name, :id)

  index do
    selectable_column
    id_column
    column :name
    column :description
    column :price
    column :stock_quantity
    column :category
    column :brand
    actions
  end

  form do |f|
    f.inputs "Product Details" do
      f.input :name
      f.input :description
      f.input :price
      f.input :stock_quantity
      f.input :category, as: :select, collection: Category.all
      f.input :brand, as: :select, collection: Brand.all
      f.input :image, as: :file
    end
    f.actions
  end

  controller do
    def destroy
      product = Product.find(params[:id])
      product.destroy
      redirect_to admin_dashboard_path, notice: "Product was successfully deleted."
    end
  end
end
