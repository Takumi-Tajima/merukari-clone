class SellerUsers::ProgressingTradesController < SellerUsers::ApplicationController
  before_action :set_seller_progressing_trade, only: %i[show update]

  def index
    @seller_progressing_trades = current_user.trades_as_sellers.uncompleted.includes(:product).default_order
  end

  def show
  end

  def update
    @seller_progressing_trade.ship!
    # TODO: メール送信処理
    redirect_to seller_users_progressing_trade_path(@seller_progressing_trade), notice: '発送が完了しました。ユーザーが商品を受け取るまでお待ちください。'
  end

  private

  def set_seller_progressing_trade
    @seller_progressing_trade = current_user.trades_as_sellers.uncompleted.find(params.expect(:id))
  end
end
