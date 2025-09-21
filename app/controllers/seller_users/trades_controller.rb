class SellerUsers::TradesController < SellerUsers::ApplicationController
  before_action :set_seller_trade, only: %i[show update]

  def index
    @seller_trades = current_user.trades_as_sellers.uncompleted.includes(:product).default_order
  end

  def show
  end

  def update
    @seller_trade.ship!
    # TODO: メール送信処理
    redirect_to seller_users_trade_path(@seller_trade), notice: '発送が完了しました。ユーザーが商品を受け取るまでお待ちください。'
  end

  private

  def set_seller_trade
    @seller_trade = current_user.trades_as_sellers.uncompleted.find(params.expect(:id))
  end
end
