module Spree
  class Shop < ActiveRecord::Base
    belongs_to :owner, :foreign_key => "user_id", :class_name => "Spree::User"
    has_many :products
  end
end
