module Spree
  class OffersController < Spree::StoreController

    def show
      _offer
    end

    def login
      _offer
    end

    def connect_new
      _offer.user = _new_user
      _post_connect
    end

    def connect_old
      _offer.user = _old_user
      _post_connect
    end

    private

    def _post_connect
      return redirect_to offer_path _offer if _offer.save
      redirect_to login_offer_path _offer
    end

    def _offer
      @offer ||= ::Spree::Offer.find! params[:id]
    end

    def _new_user
      @new_user ||= ::Spree::User.attempt_to_create! _user_params
    end

    def _user_params
      params.require(:user).permit(:email, :password, :password_confirmation)
    end

    def _login_params
      params.require(:login).permit(:email, :password)
    end

    def _old_user
      @old_user ||= login_user _login_params
    end

  end
end
