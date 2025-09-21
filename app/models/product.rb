class Product < ApplicationRecord
  belongs_to :user
  belongs_to :category
  has_one :trade, dependent: :destroy

  validates :name, presence: true
  validates :description, presence: true
  validates :price, numericality: { only_integer: true, greater_than: 0 }

  scope :default_order, -> { order(:id) }
  scope :available_for_purchase, -> { where(sold: false) }

  def sold_by?(user)
    user_id == user.id
  end

  def sold!
    update!(sold: true)
  end
end
