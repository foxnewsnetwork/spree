module Spree
  class Shop < ActiveRecord::Base
    belongs_to :user, class_name: 'Spree::User'
    belongs_to :address, class_name: 'Spree::Address'
    has_many :listings, class_name: 'Spree::Listing'
    has_many :stockpiles, class_name: 'Spree::Stockpile', through: :listings
    has_many :offers, class_name: 'Spree::Offer'
    has_many :service_supplies,
      class_name: 'Spree::Services::Supply'
    has_many :services,
      through: :service_supplies
  end
end
