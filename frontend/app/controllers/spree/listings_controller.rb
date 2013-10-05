class Spree::ListingsController < Spree::StoreController

  def new; end

  def create
    _create_listing!
    return _goto_stockpile_step   if _require_stockpile?
    return _goto_shop_step        if _require_shop?
    return _goto_complete_listing if _complete?
  end

  private

  def _goto_stockpile_step
    redirect_to new_listing_stockpile_path @listing, _stockpile_params
  end

  def _stockpile_params
    params.require(:listing).permit(:tags, :weight)
  end

  def _create_listing!
    @listing ||= _listing_maker.create! _listing_params
  end

  def _listing_maker
    current_user.try(:shop).try(:listings) || Spree::Listing
  end

  def _complete?
    !_incomplete?
  end

  def _incomplete?
    _require_shop? || require_stockpile?
  end

  def _require_shop?
    @listing.require_shop?
  end

  def _require_stockpile?
    @listing.require_stockpile?
  end

  def _listing_params
    _raw_post_listing_params
  end

  def _raw_post_listing_params
    params.require(:listing).permit(:available_on, :expires_on)
  end

end