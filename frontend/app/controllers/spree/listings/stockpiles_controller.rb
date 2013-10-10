class Spree::Listings::StockpilesController < Spree::StoreController
  rescue_from ActiveRecord::RecordNotFound, with: :_check_stockpiles_error
  rescue_from ActiveRecord::RecordInvalid, with: :_check_stockpiles_error
  rescue_from Spree::InvalidInput, with: :_check_stockpiles_error
  def new
    _listing
  end

  def create
    _attach_stockpile_to_listing!
    return _goto_address_step     if _require_address?
    return _goto_shop_step        if _require_shop?
    return _goto_complete_listing if _complete?
  end

  private

  def _check_stockpiles_error(e)
    manager = Spree::Listings::Stockpiles::ErrorManager.new e
    flash[:error] = manager.flash_message
    return _reload_this_step if manager.bad_user_input?
    return render_404
  end

  def _reload_this_step
    redirect_to new_listing_stockpile_path(_listing, _raw_stockpile_params)
  end

  def _goto_address_step
    redirect_to new_stockpile_address_path _stockpile
  end

  def _require_address?
    _stockpile.require_address?
  end

  def _attach_stockpile_to_listing!
    _listing.stockpile = _stockpile
    _listing.save!
  end

  def _stockpile
    @stockpile ||= Spree::Stockpile.create!(_stockpile_params)
  end

  def _stockpile_params
    @stockpile_params ||= _processed_stockpile_params.tap do |hash|
      hash[:option_values] = [:packaging, :process_state, :origin].map do |key| 
        hash.delete(key) || _consider_raise_input_error!(key) 
      end.reject(&:blank?)
    end
  end

  def _consider_raise_input_error!(key)
    raise Spree::InvalidInput.new(key) unless key == :process_state
  end

  def _processed_stockpile_params
    _raw_stockpile_params.tap do |hash|
      hash[:material] = Spree::Material.find hash[:material]
    end.access_map! :packaging, :process_state do |id|
      Spree::OptionValue.normalize! id
    end.access_map! :origin do |presentation|
      Spree::OriginProduct.find_or_create_by! presentation: presentation
    end.alter_key_from!(:weight).to(:pounds_on_hand)
  end

  def _required_stockpile_params
    params.require(:stockpile).permit(:material, :weight, :packaging, :process_state, :origin)
  end

  def _optional_stockpile_params
    params.require(:stockpile).permit :notes
  end

  def _raw_stockpile_params
    _required_stockpile_params.merge _optional_stockpile_params
  end

  def _listing
    @listing ||= Spree::Listing.find params[:listing_id]
  end
end