module Spree
  class Shop < ActiveRecord::Base
    belongs_to :user, class_name: 'Spree::User'
    has_many :listings, class_name: 'Spree::Listing'

  end
end
