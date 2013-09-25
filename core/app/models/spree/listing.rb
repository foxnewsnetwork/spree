module Spree
  class Listing < ActiveRecord::Base
    belongs_to :shop, class_name: 'Spree::Shop'
    belongs_to :stockpile, class_name: 'Spree::Stockpile'
    has_one :address,
      through: :stockpile,
      class_name: 'Spree::Address'
  end
end
