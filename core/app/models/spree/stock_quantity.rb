module Spree
  class StockQuantity < ActiveRecord::Base
    belongs_to :variant, class_name: "Spree::Variant"

    def in_stock?(quantity=0)
      pounds_on_hand.to_i >= quantity.to_i
    end

    def restock!(quantity)
      update_attributes! :pounds_on_hand => quantity
    end

    def start_on!(date)
      update_attributes! :availability_start => date
    end

    def end_on!(date)
      update_attributes! :availability_end => date
    end

  end
end
