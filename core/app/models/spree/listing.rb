module Spree
  class Listing < ActiveRecord::Base
    belongs_to :shop, class_name: 'Spree::Shop'
    belongs_to :stockpile, class_name: 'Spree::Stockpile'
    has_one :address,
      through: :stockpile,
      class_name: 'Spree::Address'
    has_many :offers, 
      -> { completed },
      class_name: 'Spree::Offer'

    delegate :name, :require_address?, :to => :stockpile

    def seller_offer
      offers.where(id: shop.user_id).first
    end

    def max_offer
      offers.sort do |a,b|
        a.total_usd <=> b.total_usd
      end.last
    end

    def require_shop?
      shop.blank?
    end

    def require_stockpile?
      stockpile.blank?
    end

    def complete?
      !incomplete?
    end

    def incomplete?
      require_stockpile? || require_shop?
    end

  end
end
