module Spree
  class TransportationPrice < ActiveRecord::Base
    belongs_to :price, :class_name => "Spree::Price"
    belongs_to :address, :class_name => "Spree::Address"
    belongs_to :destination, :class_name => "Spree::Address"
  end
end
