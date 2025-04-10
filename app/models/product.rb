class Product < ApplicationRecord
  belongs_to :category
  belongs_to :brand
  has_many :order_items

  validates :name, presence: true
  validates :description, presence: true
  validates :price, presence: true
  validates :stock_quantity, presence: true
  validates :category, presence: true
  validates :brand, presence: true
end
