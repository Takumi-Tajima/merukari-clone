class User < ApplicationRecord
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable, :trackable, :confirmable

  has_many :trades_as_buyers, class_name: 'Trade', foreign_key: 'buyer_id', dependent: :destroy, inverse_of: :buyer
  has_many :trades_as_sellers, class_name: 'Trade', foreign_key: 'seller_id', dependent: :destroy, inverse_of: :seller
  has_many :products, dependent: :destroy
end
