ActiveAdmin.register Order do
  permit_params :customer_id, :status, :total_price, :stripe_payment_id, :payment_intent_id, :paid

  index do
    selectable_column
    id_column
    column :customer
    column :status
    column :total_price
    column :paid
    column :created_at
    actions
  end

  filter :customer
  filter :status
  filter :paid
  filter :created_at

  form do |f|
    f.inputs do
      f.input :customer, as: :select, collection: Customer.all.map { |c| [c.name, c.id] }
      f.input :status
      f.input :total_price
      f.input :stripe_payment_id
      f.input :payment_intent_id
      f.input :paid
    end
    f.actions
  end

  show do
    attributes_table do
      row :customer
      row :status
      row :total_price
      row :stripe_payment_id
      row :payment_intent_id
      row :paid
      row :created_at
      row :updated_at
    end

    panel "Order Items" do
      table_for order.order_items do
        column :product
        column :quantity
        column :price
      end
    end
  end
end
