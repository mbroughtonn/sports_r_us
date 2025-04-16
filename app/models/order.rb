class Order < ApplicationRecord
  belongs_to :customer
  belongs_to :user, optional: true
  has_many :order_items

  validates :status, presence: true, inclusion: { in: ['pending', 'shipped', 'delivered'] }
  validates :total_price, numericality: { greater_than_or_equal_to: 0 }
end
