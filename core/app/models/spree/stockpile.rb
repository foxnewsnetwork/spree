module Spree
  class Stockpile < ActiveRecord::Base
    belongs_to :material, :class_name => 'Spree::Material'
    belongs_to :address, :class_name => 'Spree::Address'
  end
end
