module Spree
  class PostTransaction < ActiveRecord::Base
    belongs_to :finalization
    has_many :rating, as: :reviewable
  end
end
