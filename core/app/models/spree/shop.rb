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

    has_many :received_ratings,
      class_name: 'Spree::Rating',
      foreign_key: 'shop_id'

    has_many :given_ratings,
      class_name: 'Spree::Rating',
      foreign_key: 'reviewer_id'

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

    def rating_stars
      received_average_stars.ceil
    end

    def rating_score
      _averge_something { |rating| rating.score }
    end
    alias_method :rating_summary_score, :rating_score

    def received_percentage
      received_average_stars.to_f / Spree::Rating.max_possible_stars
    end

    def received_average_stars
      _averge_something { |rating| rating.stars }
    end

    def rating_trustworthiness_score 
      _averge_something { |rating| rating.trustworthiness }
    end

    def rating_simplicity_score 
      _averge_something { |rating| rating.simplicity }
    end

    def rating_agreeability_score 
      _averge_something { |rating| rating.agreeability }
    end


    private

    def _averge_something(n=nil, &block)
      return if received_ratings.blank?
      n ||= received_ratings.count
      return yield(received_ratings.first) if 0 >= n
      _averge_something(n-1, &block) * ( 1 - 1.0 / n) + yield(received_ratings[n-1]) / n.to_f
    end

  end
end
