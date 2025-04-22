class Category < ApplicationRecord
  has_many :products, dependent: :destroy

  validates :name, presence: true, uniqueness: true
  validates :description, presence: false

  def self.ransackable_associations(auth_object = nil)
    ["products"]
  end
end
