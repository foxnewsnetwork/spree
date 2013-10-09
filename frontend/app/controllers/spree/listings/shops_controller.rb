class Spree::Listings::ShopsController < Spree::StoreController
  before_filter :_force_signin

  def new
    _listing
  end

  def create
    _attach_shop_to_listing! if _require_shop?
    _attach_picture_to_listing!
    _goto_complete_step
  end

  private

  def _goto_complete_step
    redirect_to _listing
  end

  def _attach_shop_to_listing!
    _listing.shop = _shop
    _listing.save!
  end

  def _attach_picture_to_listing!
    _listing.images.create! attachment: _image
  end

  def _image
    @image ||= params[:stockpile][:image]
  end

  def _shop
    @shop ||= current_user!.shop
    @shop ||= Spree::Shop.create! _shop_params
  end

  def _shop_params
    params.require(:stockpile).permit(:name, :email).merge user: current_user!
  end

  def _require_shop?
    _listing.require_shop?
  end

  def _force_signin
    redirect_to login_path _back_params unless user_signed_in?
  end

  def _back_params
    { back: new_listing_shops_path _listing}
  end

  def _listing
    @listing ||= Spree::Listing.find params[:listing_id]
  end
end