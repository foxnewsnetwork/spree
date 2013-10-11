class Spree::ListingsController < Spree::StoreController
  rescue_from ActiveRecord::RecordNotFound, with: :_check_stockpiles_error
  rescue_from ActiveRecord::RecordInvalid, with: :_check_stockpiles_error
  rescue_from Spree::InvalidInput, with: :_check_stockpiles_error

  def show
    redirect_to stockpile_path Spree::Listing.find(params[:id]).stockpile
  end

  def new; end

  def create
    _listing
    _goto_address_step
  end

  private

  def _check_stockpiles_error(e)
    manager = Spree::Listings::ExceptionHandler.new e
    flash[:error] = manager.flash_message
    return _reload_this_step if manager.bad_user_input?
    return render_404
  end

  def _reload_this_step
    redirect_to new_listing_path _raw_stockpile_params
  end

  def _goto_address_step
    redirect_to new_stockpile_address_path _stockpile
  end

  def _listing
    @listing ||= _listing_maker.create! _listing_params
  end

  def _listing_maker
    current_user.try(:shop).try(:listings) || Spree::Listing
  end

  def _listing_params
    params.require(:listing).permit(:available_on, :expires_on).merge stockpile: _stockpile
  end

  def _stockpile
    @stockpile ||= Spree::Stockpile.create!(_stockpile_params)
  end

  def _stockpile_params
    Spree::Listings::StockpileParamsProcessor.new(_raw_stockpile_params).stockpile_params
  end

  def _raw_stockpile_params
    params.require(:listing).permit(:material, :weight, :packaging, :process_state, :origin_products, :notes)
  end

end