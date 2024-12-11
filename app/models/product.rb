class Product < ApplicationRecord
  belongs_to :category
  has_many :order_items
  validates :title, :price, :stock_quantity, presence: true
end