class Spree::Listings::StockpilesController < Spree::StoreController

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
        hash.delete key
      end.reject(&:blank?)
    end
  end

  def _processed_stockpile_params
    _raw_stockpile_params.access_map! :material do |id|
      Spree::Material.find id
    end.access_map! :packaging, :process_state, :origin do |id|
      Spree::OptionValue.find id
    end.alter_key_from!(:weight).to(:pounds_on_hand)
  end

  def _raw_stockpile_params
    params.require(:stockpile).permit :material, 
      :weight, 
      :notes, 
      :packaging, 
      :process_state, 
      :origin
  end

  def _listing
    @listing ||= Spree::Listing.find params[:listing_id]
  end
end