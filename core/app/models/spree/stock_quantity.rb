module Spree
  class StockQuantity < ActiveRecord::Base
    belongs_to :variant, class_name: "Spree::Variant"

    def in_stock?(quantity=0)
      available? &&
      pounds_on_hand.to_i >= quantity.to_i
    end

    def available?
      already_started? && still_unfinished?
    end

    def already_started?
      availability_start.blank? || availability_start < Time.now
    end

    def still_unfinished?
      availability_end.blank? || Time.now < availability_end
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
