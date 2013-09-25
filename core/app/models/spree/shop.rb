module Spree
  class Shop < ActiveRecord::Base
    belongs_to :user, class_name: 'Spree::User'
    belongs_to :address, class_name: 'Spree::Address'
    has_many :listings, class_name: 'Spree::Listing'

  end
end
