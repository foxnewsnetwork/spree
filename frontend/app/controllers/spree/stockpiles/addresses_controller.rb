class Spree::Stockpiles::AddressesController < Spree::StoreController
  rescue_from ActiveRecord::RecordNotFound, :with => :render_404

  def new
    _stockpile
  end

  def create
    _attach_address_to_stockpile!
    return _goto_shop_step if _require_shop?
    return _goto_complete_step if _complete?
  end

  private

  def _goto_shop_step
    redirect_to new_listing_shop_path _stockpile.listing
  end

  def _require_shop?
    _stockpile.require_shop?
  end

  def _attach_address_to_stockpile!
    _stockpile.address = _address
    _stockpile.save!
  end

  def _address
    @address ||= Spree::Address.find_roughly_or_create_by _address_params
  end

  def _address_params
    params.require(:address).permit :address1,
      :address2,
      :city,
      :zipcode,
      :state,
      :country
  end

  def _stockpile
    @stockpile ||= Spree::Stockpile.find params[:stockpile_id]
  end
end