module Spree
  class Offer < ActiveRecord::Base
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

    def total_usd
      containers.to_i * usd_per_pound * PoundsPerContainer
    end
  end
end
