module ApplicationHelper
  def trade_status_tag(trade)
    if trade.completed_at.present?
      '取引完了'
    elsif trade.shipping_at.present?
      '配送中'
    elsif trade.confirmed_at.present?
      '発送待ち'
    end
  end
end
