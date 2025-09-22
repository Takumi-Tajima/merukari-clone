class BuyerUsers::CompletedTradesController < BuyerUsers::ApplicationController
  def index
    @buyer_completed_trades = current_user.trades_as_buyers.completed.includes(:product).default_order
  end

  def show
    @buyer_completed_trade = current_user.trades_as_buyers.completed.find(params.expect(:id))
  end
end
