class SellerMailer < ApplicationMailer
  def product_purchased_notification(trade)
    @trade = trade
    mail(to: @trade.seller.email, subject: "商品が購入されました - #{@trade.product.name}")
  end

  def trade_completed_notification(trade)
    @trade = trade
    mail(to: @trade.seller.email, subject: "取引が完了しました - #{@trade.product.name}")
  end
end
