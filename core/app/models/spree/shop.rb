module Spree
  class Shop < ActiveRecord::Base
    belongs_to :user, class_name: 'Spree::User'
    belongs_to :address, class_name: 'Spree::Address'
    has_many :listings, class_name: 'Spree::Listing'
    has_many :stockpiles, class_name: 'Spree::Stockpile', through: :listings
  end
end
