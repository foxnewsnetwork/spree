class Spree::OffersController < Spree::StoreController
  rescue_from ActiveRecord::RecordNotFound, with: :render_404
  include Spree::OffersHelper
  include Spree::UserFilterHelper
  before_filter :filter_anonymous_users, :filter_incorrect_users, except: [:show]
  def show
    _offer
  end

  def edit
    _offer
  end

  def update
    _consider_update_offer!
    _setup_flash!
    render :edit
  end

  private

  def _correct_shop
    _offer.shop
  end

  def _setup_flash!
    flash[:notice] = Spree.t(:update_successful) if _valid?
    flash[:error] = Spree.t(:something_went_wrong) unless _valid?
  end

  def _valid?
    _offer_edit_helper.valid?
  end

  def _consider_update_offer!
    _offer.update! _offer_edit_helper.offer_params if _valid?
  end

  def _offer_edit_helper
    @offer_edit_helper ||= Spree::Offers::EditFormHelper.new _raw_params
  end

  def _raw_params
    params.require(:offer).permit *Spree::Offers::ParamsProcessor::AllFields
  end

  def _offer
    @offer ||= Spree::Offer.find params[:id]
  end
end