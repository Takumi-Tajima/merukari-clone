class Trade < ApplicationRecord
  SELLING_FEE_RATE = 0.1

  belongs_to :buyer, class_name: 'User', inverse_of: :trades_as_buyers
  belongs_to :seller, class_name: 'User', inverse_of: :trades_as_sellers
  belongs_to :product

  validates :product_id, uniqueness: true
  validates :buyer_name, presence: true
  validates :buyer_zipcode, presence: true
  validates :buyer_address, presence: true
  validates :buyer_phone_number, presence: true
  validates :confirmed_at, presence: true
  validates :selling_fee, numericality: { only_integer: true, greater_than: 0 }
  validates :product_price, numericality: { only_integer: true, greater_than: 0 }

  scope :default_order, -> { order(:id) }
  scope :uncompleted, -> { where(completed_at: nil) }

  def save_as_confirmed_purchase
    ActiveRecord::Base.transaction do
      self.seller = product.user
      self.buyer_name = buyer.name
      self.buyer_zipcode = buyer.zipcode
      self.buyer_address = buyer.address
      self.buyer_phone_number = buyer.phone_number
      self.product_price = product.price
      self.selling_fee = calculate_selling_fee(product.price)
      self.confirmed_at = Time.current

      if save
        product.sold!
        true
      else
        false
      end
    end
  rescue ActiveRecord::RecordInvalid
    false
  end

  def ship!
    update!(shipping_at: Time.current)
  end

  def shipped?
    shipping_at.present?
  end

  def receive!
    update!(completed_at: Time.current)
  end

  private

  def calculate_selling_fee(product_price)
    (BigDecimal(product_price) * BigDecimal(SELLING_FEE_RATE.to_s)).round.to_i
  end
end
