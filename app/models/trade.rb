class Trade < ApplicationRecord
  belongs_to :buyer, class_name: 'User', inverse_of: :trades_as_buyer
  belongs_to :seller, class_name: 'User', inverse_of: :trades_as_seller
  belongs_to :product
end
