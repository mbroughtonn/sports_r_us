class Product < ApplicationRecord
  belongs_to :category
  belongs_to :brand
  has_many :order_items

  validates :product_name, :price, :stock_quantity, presence: true
  validates :product_name, uniqueness: true
  validates :stock_quantity, numericality: { greater_than_or_equal_to: 0 }
end
