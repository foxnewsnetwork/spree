class Spree::ListingsController < Spree::StoreController

  def show
    redirect_to stockpile_path Spree::Listing.find(params[:id]).stockpile
  end

  def new; end

  def create
    _create_listing!
    _goto_stockpile_step
  end

  private

  def _goto_stockpile_step
    redirect_to new_listing_stockpile_path @listing, _stockpile_params
  end

  def _stockpile_params
    params.require(:listing).permit(:material, :weight)
  end

  def _create_listing!
    @listing ||= _listing_maker.create! _listing_params
  end

  def _listing_maker
    current_user.try(:shop).try(:listings) || Spree::Listing
  end

  def _listing_params
    _raw_post_listing_params
  end

  def _raw_post_listing_params
    params.require(:listing).permit(:available_on, :expires_on)
  end

end