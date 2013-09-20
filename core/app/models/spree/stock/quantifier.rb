module Spree
  module Stock
    class Quantifier
      attr_reader :stock_quantity

      def initialize(variant)
        @variant = Spree::Variant.find variant
        @stock_quantity = @variant.stock_quantity
      end

      def total_on_hand
        if Spree::Config.track_inventory_levels
          stock_quantity.pounds_on_hand
        else
          Float::INFINITY
        end
      end

      # Not supported
      def backorderable?
        false
      end

      def can_supply?(required)
        total_on_hand >= required || backorderable?
      end
    end
  end
end
