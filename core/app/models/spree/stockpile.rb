module Spree
  class Stockpile < ActiveRecord::Base
    belongs_to :material, :class_name => 'Spree::Material'
    belongs_to :address, :class_name => 'Spree::Address'
    has_and_belongs_to_many :option_values, join_table: :spree_option_values_stockpiles
    has_many :images, -> { order(:position) }, as: :viewable, dependent: :destroy, class_name: "Spree::Image"

    def name
      @name ||= "#{material.name} #{_option_value_names}"
    end

    def image_name
      "plastic-#{material.name}".downcase
    end

    private

    def _option_value_names
      option_values.map(&:presentation).sort.join " "
    end
  end
end
