module Spree
  class Shop < ActiveRecord::Base
    belongs_to :user, class_name: 'Spree::User'
    belongs_to :address, class_name: 'Spree::Address'
    has_many :listings, class_name: 'Spree::Listing'
    has_many :stockpiles, class_name: 'Spree::Stockpile', through: :listings
    has_many :offers, class_name: 'Spree::Offer'
    has_many :finalizations,
      through: :offers
    has_many :service_supplies
    has_many :service_contacts
    has_many :serviceables,
      through: :service_contacts

    def top_listings(n=5)
      listings.sort do |l1,l2|
        l2.latest_offer.created_at <=> l1.latest_offer.created_at
      end.take n
    end

    def top_offers(n=5)
      offers.order("created_at desc").limit 5
    end

    def top_finalizations(n=5)
      finalizations.fresh.limit n
    end
  end
end
