class Spree::Offers::UsersController < Spree::StoreController
  rescue_from ActiveRecord::RecordNotFound, :with => :render_404
  
  def create

  end

  def new
    _offer
  end

  private

  def _offer
    @offer ||= Spree::Offer.find params[:offer_id]
  end
  
end