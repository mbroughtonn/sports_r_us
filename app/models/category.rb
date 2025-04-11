class Category < ApplicationRecord
  has_many :products, dependent: :destroy

  validates :name, presence: true, uniqueness: true

  def self.ransackable_associations(auth_object = nil)
    ["products"]
  end
end
