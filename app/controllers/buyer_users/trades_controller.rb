class BuyerUsers::TradesController < BuyerUsers::ApplicationController
  def index
    @buyer_trades = current_user.trades_as_buyers.uncompleted.includes(:product).default_order
  end

  def show
    @buyer_trade = current_user.trades_as_buyers.uncompleted.find(params.expect(:id))
  end

  def create
    product = Product.available_for_purchase.find(params.expect(:product))
    @trade = current_user.trades_as_buyers.build(product:)

    if @trade.save_as_confirmed_purchase
      redirect_to buyer_users_trade_path(@trade), notice: '商品の購入が完了しました。'
    else
      redirect_to product_path(params.expect(:product)), status: :unprocessable_content, alert: '商品の購入に失敗しました。'
    end
  end
end
