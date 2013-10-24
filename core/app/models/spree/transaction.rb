module Spree
  class Transaction < ActiveRecord::Base
    acts_as_paranoid
    belongs_to :offer

    def fresh?
      Time.now < _expiration_date
    end

    private

    def _expiration_date
      expires_at || 1000.years.from_now
    end
  end
end
