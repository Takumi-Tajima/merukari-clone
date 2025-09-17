class Category < ApplicationRecord
  validates :name, presence: true, uniqueness: true

  has_many :products, dependent: :restrict_with_exception

  # TODO: ソートは日本語の50音順にする
  scope :default_order, -> { order(:id) }
end
