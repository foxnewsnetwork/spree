class Spree::OffersController < Spree::StoreController

  def show
    _offer
  end

  private

  def _offer
    @offer ||= Spree::Offer.find params[:id]
  end
end