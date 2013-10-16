class Spree::ListingsController < Spree::StoreController
  rescue_from ActiveRecord::RecordNotFound, with: :render_404

  def show
    redirect_to stockpile_path Spree::Listing.find(params[:id]).stockpile
  end

  def new; end

  def create
    if _valid?
      _listing and _goto_address_step
    else
      _handle_flash and _reload_this_step
    end
  end

  private

  def _handle_flash
    flash[:error] = _form_helper.flash_message
  end

  def _valid?
    _form_helper.valid?
  end

  def _reload_this_step
    render "new"
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
    listing = params.require(:listing_form_helper).permit :available_on, :expires_on
    listing.merge stockpile: _stockpile
  end

  def _stockpile
    @stockpile ||= Spree::Stockpile.create!(_stockpile_params)
  end

  def _form_helper
    @form_helper ||= Spree::Listings::FormHelper.new _raw_stockpile_params
  end

  def _stockpile_params
    _form_helper.stockpile_params
  end

  def _raw_stockpile_params
    params.require(:listing_form_helper).permit :material, 
      :pounds_on_hand, 
      :packaging, 
      :process_state, 
      :origin_products, 
      :notes
  end

end