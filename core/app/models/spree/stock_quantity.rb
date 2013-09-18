module Spree
  class StockQuantity < ActiveRecord::Base
    belongs_to :variant, class_name: "Spree::Variant"

    def in_stock?
      !pounds_on_hand.to_i.zero?
    end

    def restock!(quantity)
      update_attributes! :pounds_on_hand => quantity
    end

    def start_on!(date)
      update_attributes! :availability_starts => date
    end

    def end_on!(date)
      update_attributes! :availability_ends => date
    end

  end
end
