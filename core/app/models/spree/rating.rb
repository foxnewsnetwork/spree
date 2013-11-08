module Spree
  class Rating < ActiveRecord::Base
    acts_as_paranoid
    belongs_to :shop
    belongs_to :reviewed,
      class_name: 'Spree::Shop',
      foreign_key: 'shop_id'
    belongs_to :reviewer,
      class_name: 'Spree::Shop',
      foreign_key: 'reviewer_id'

    belongs_to :reviewable, polymorphic: true

    validates :trustworthiness, 
      :simplicity, 
      :agreeability,
      numericality: true,
      inclusion: { :in => 0..100 }
  end
end
