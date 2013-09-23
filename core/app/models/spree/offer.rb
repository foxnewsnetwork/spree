module Spree
  class Offer < ActiveRecord::Base
    belongs_to :user, class_name: 'Spree::User'
    belongs_to :price, class_name: 'Spree::Price'
    has_one :variant, through: :price
    has_one :origination, 
      through: :variant,
      class_name: 'Spree::Address'
    has_one :destination,
      through: :price,
      class_name: 'Spree::Address'
  end
end
