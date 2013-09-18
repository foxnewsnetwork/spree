module Spree
  class User < ActiveRecord::Base
    has_one :shop, :class_name => "Spree::Shop"
  end
end