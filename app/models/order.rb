class Order < ApplicationRecord
  belongs_to :customer
  has_many :order_items

  validates :status, presence: true, inclusion: { in: ['pending', 'shipped', 'delivered'] }
end
