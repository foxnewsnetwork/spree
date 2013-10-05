class Spree::Listings::StockpilesController < Spree::StoreController

  def new
    _listing
  end

  private

  def _listing
    Spree::Listing.find params[:listing_id]
  end
end