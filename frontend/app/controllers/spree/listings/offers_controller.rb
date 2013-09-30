class Spree::Listings::OffersController < Spree::StoreController
  rescue_from ActiveRecord::RecordNotFound, :with => :render_404
  helper 'spree/taxons'

  def create
    return redirect_to new_address_offers_path _offer if _offer.requires_destination?
    return redirect_to new_user_offers_path _offer if _offer.requires_buyer?
    return redirect_to offer_path _offer if _offer.complete?
  end


  private

  def _offer
    @offer ||= _listing.offers.create _offer_params
  end

  def _listing
    Spree::Listing.find params[:listing_id]
  end

  def _offer_params
    params.require(:offer).permit(:containers, :shipping_terms, :usd_per_pound).merge _relationship_params
  end

  def _relationship_params
    {
      address: _address,
      user: _user
    }
  end

  def _address
    @address ||= Spree::Address.new _address_params
  end

  def _address_params
    params.require(:offer).permit(:country, :state, :city)
  end

end