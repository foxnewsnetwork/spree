module Spree
  class Offer < ActiveRecord::Base
    acts_as_paranoid
    FAS = "FAS"
    CNF = "CNF"
    CIF = "CIF"
    FOB = "FOB"
    EXWORKS = "EXWORKS"
    Terms = [FAS, CNF, CIF, FOB, EXWORKS]
    PoundsPerContainer = 40000

    belongs_to :user
    belongs_to :listing
    belongs_to :address

    belongs_to :destination, 
      class_name: 'Spree::Address',
      foreign_key: 'address_id'

    has_one :origination,
      class_name: 'Spree::Address',
      through: :listing

    has_one :stockpile,
      through: :listing

    validates :listing_id, presence: true

    delegate :name, :to => :listing

    scope :destined,
      -> { where("address_id is not null") }
    scope :possessed,
      -> { where "user_id is not null" }
    scope :relevant,
      -> { where "listing_id is not null" }
    scope :fresh,
      -> { where("expires_at is null or expires_at > ?", Time.now) }
    scope :completed,
      -> { destined.possessed.relevant.fresh }

    def total_usd
      containers.to_i * usd_per_pound * PoundsPerContainer
    end

    def to_summary
      "#{containers.to_i} containers @ #{usd_per_pound} / lbs " + _shipping_summary
    end

    def requires_destination?
      destination.blank?
    end

    def requires_buyer?
      user.blank?
    end

    def complete?
      !incomplete?
    end

    def incomplete?
      requires_destination? || requires_buyer?
    end

    def expired?
      Time.now > _expiration_date
    end

    private

    def _expiration_date
      expires_at.blank? ? 1000.years.from_now : expires_at
    end

    def _shipping_summary
      return shipping_terms if shipping_terms == EXWORKS
      "#{shipping_terms} #{destination.try :permalink_name}"
    end
  end
end
