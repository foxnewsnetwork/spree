module Spree
  class Listing < ActiveRecord::Base
    belongs_to :shop, class_name: 'Spree::Shop'
    belongs_to :stockpile, class_name: 'Spree::Stockpile'
    has_one :address,
      through: :stockpile,
      class_name: 'Spree::Address'
    has_many :offers, class_name: 'Spree::Offer'

    def seller_offer
      offers.where(id: shop.user_id).first
    end

    def max_offer
      offers.sort do |a,b|
        a.total_usd <=> b.total_usd
      end.last
    end

  end
end
