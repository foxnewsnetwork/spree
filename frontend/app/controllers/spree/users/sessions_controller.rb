class Spree::Users::SessionsController < Spree::StoreController
  before_filter :_back_path
  
  def new; end

  private

  def _back_path
    @back_path ||= params[:back]
  end
end