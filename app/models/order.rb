class Order < ApplicationRecord
  belongs_to :customer, optional: true
  has_many :order_items, dependent: :destroy
  has_many :products, through: :order_items

  validates :status, presence: true
  validates :total_price, presence: true, numericality: { greater_than_or_equal_to: 0 }

  def self.ransackable_attributes(auth_object = nil)
    %w[
      id
      status
      total_price
      paid
      stripe_payment_id
      payment_intent_id
      created_at
      updated_at
      user_id
    ]
  end
end
