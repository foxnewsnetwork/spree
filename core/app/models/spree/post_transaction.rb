module Spree
  class PostTransaction < ActiveRecord::Base
    belongs_to :finalization
    has_many :rating, as: :reviewable

    delegate :relevant_shops, to: :finalization
  end
end
