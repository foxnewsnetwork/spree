class Spree::Stockpiles::AddressesController < Spree::StoreController
  rescue_from ActiveRecord::RecordNotFound, with: :_manage_exceptions
  rescue_from ActiveRecord::RecordInvalid, with: :_manage_exceptions

  before_filter :_consider_skipping_to_next_step
  def new
    _stockpile
  end

  def create
    _attach_address_to_stockpile!
    _goto_shop_step
  end

  private

  def _manage_exceptions(e)
    handler = Spree::Stockpiles::Addresses::ExceptionHandler.new e
    flash[:error] = handler.flash_message
    return _reload_this_step if handler.user_input_error?
    render_404
  end

  def _reload_this_step
    redirect_to new_stockpile_address_path(_stockpile, _address_params)
  end

  def _consider_skipping_to_next_step
    _goto_shop_step unless _require_address?
  end

  def _require_address?
    _stockpile.require_address?
  end

  def _goto_shop_step
    redirect_to new_listing_shop_path _stockpile.listing
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