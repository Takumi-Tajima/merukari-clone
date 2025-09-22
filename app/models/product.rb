class Product < ApplicationRecord
  IMAGE_SETTINGS = {
    content_type: %w[image/png image/jpg image/jpeg],
    max_size: 5.megabytes,
    thumbnail_size: [300, 300],
    display_size: [600, 600],
  }.freeze

  has_one_attached :image do |attachable|
    attachable.variant :thumbnail, resize_to_limit: IMAGE_SETTINGS[:thumbnail_size]
    attachable.variant :display, resize_to_limit: IMAGE_SETTINGS[:display_size]
  end

  belongs_to :user
  belongs_to :category
  has_one :trade, dependent: :destroy

  validates :name, presence: true
  validates :description, presence: true
  validates :price, numericality: { only_integer: true, greater_than: 0 }
  validate :validate_image_type
  validate :validate_image_size

  scope :default_order, -> { order(:id) }
  scope :available_for_purchase, -> { where(sold: false) }

  def sold_by?(user)
    user_id == user.id
  end

  def sold!
    update!(sold: true)
  end

  private

  def validate_image_type
    return unless image.attached?

    unless IMAGE_SETTINGS[:content_type].include?(image.blob.content_type)
      errors.add(:image, '画像はPNG、JPG、JPEGのいずれかの形式でアップロードしてください')
    end
  end

  def validate_image_size
    return unless image.attached?

    if image.blob.byte_size > IMAGE_SETTINGS[:max_size]
      errors.add(:image, "画像のサイズは#{IMAGE_SETTINGS[:max_size] / 1.megabyte}MB以下にしてください")
    end
  end
end
