module Spree
  class Finalization < ActiveRecord::Base
    acts_as_paranoid
    belongs_to :offer
    has_many :service_demands
    has_many :service_contacts
    has_many :serviceables,
      through: :service_contacts
    
    scope :fresh, -> { where "expires_at is null or expires_at > ?", Time.now }

    def fresh?
      Time.now < _expiration_date
    end

    private

    def _expiration_date
      expires_at || 1000.years.from_now
    end
  end
end
