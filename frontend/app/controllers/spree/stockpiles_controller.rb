class Spree::StockpilesController < Spree::StoreController
  rescue_from ActiveRecord::RecordNotFound, :with => :render_404
  helper 'spree/taxons'

  def index

  end

  def show
    _stockpile
  end

  private

  def accurate_title
    _stockpile.present? ? _stockpile.name : super
  end

  def _stockpile
    @stockpile ||= Spree::Stockpile.find_by_id! params[:id]
  end
end
