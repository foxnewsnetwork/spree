module Spree
  class Stockpile < ActiveRecord::Base
    belongs_to :material, :class_name => 'Spree::Material'
    belongs_to :address, :class_name => 'Spree::Address'
    has_and_belongs_to_many :option_values, join_table: :spree_option_values_stockpiles
  end
end
