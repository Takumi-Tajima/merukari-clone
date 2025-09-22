class SellerUsers::CompletedTradesController < SellerUsers::ApplicationController
  def index
    @seller_completed_trades = current_user.trades_as_sellers.completed.includes(:product).default_order
  end

  def show
    @seller_completed_trade = current_user.trades_as_sellers.completed.find(params.expect(:id))
  end
end
