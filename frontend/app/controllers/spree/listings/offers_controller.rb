class Spree::Listings::OffersController < Spree::StoreController
  rescue_from ActiveRecord::RecordNotFound, :with => :render_404
  helper 'spree/taxons'

  def create
    return redirect_to _offer if _offer.save!
    redirect_to _listing_offer
  end

  private
  def _offer

  end

end