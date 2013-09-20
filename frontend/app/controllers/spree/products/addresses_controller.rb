module Spree
  class Products::AddressesController < ::Spree::StoreController
    helper 'spree/products'
    def show
      _variants
    end

    private

    def accurate_title
      _product.present? ? _product.name : super
    end

    def _variants
      @variants ||= _product.variants.where :address_id => params[:id]
    end

    def _product
      @product ||= ::Spree::Product.find_by_permalink! params[:product_id]
    end
  end
end