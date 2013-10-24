module Spree
  class Transaction < ActiveRecord::Base
    acts_as_paranoid
    belongs_to :offer

  end
end
