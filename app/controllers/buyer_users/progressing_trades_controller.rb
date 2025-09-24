class BuyerUsers::ProgressingTradesController < BuyerUsers::ApplicationController
  before_action :set_buyer_progressing_trade, only: %i[show update]

  def index
    @buyer_progressing_trades = current_user.trades_as_buyers.uncompleted.includes(:product).default_order
  end

  def show
  end

  def create
    product = Product.available_for_purchase.find(params.expect(:product))
    @trade = current_user.trades_as_buyers.build(product:)

    if @trade.save_as_confirmed_purchase
      SellerMailer.product_purchased_notification(@trade).deliver_later
      redirect_to buyer_users_progressing_trade_path(@trade), notice: '商品の購入が完了しました。'
    else
      redirect_to product_path(params.expect(:product)), status: :unprocessable_content, alert: '商品の購入に失敗しました。'
    end
  end

  def update
    @buyer_progressing_trade.receive!
    SellerMailer.trade_completed_notification(@buyer_progressing_trade).deliver_later
    redirect_to products_path, notice: '取引が完了しました。ご利用ありがとうございました。'
  end

  private

  def set_buyer_progressing_trade
    @buyer_progressing_trade = current_user.trades_as_buyers.uncompleted.find(params.expect(:id))
  end
end
