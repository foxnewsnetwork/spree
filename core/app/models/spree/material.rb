module Spree
  class Material < ActiveRecord::Base

    has_many :stockpiles, class_name: 'Spree::Stockpile'
  end
end
