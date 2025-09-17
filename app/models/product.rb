class Product < ApplicationRecord
  belongs_to :user
  belongs_to :category

  validates :name, presence: true
  validates :description, presence: true
  validates :price, numericality: { only_integer: true, greater_than: 0 }

  scope :default_order, -> { order(:id) }
end
