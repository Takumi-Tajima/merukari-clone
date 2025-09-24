class BuyerMailer < ApplicationMailer
  def product_shipped_notification(trade)
    @trade = trade
    mail(to: @trade.buyer.email, subject: "商品が発送されました - #{@trade.product.name}")
  end
end
