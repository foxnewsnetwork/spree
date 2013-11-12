class Spree::Serviceable < ActiveRecord::Base
  has_one :service_contract, as: :serviceable
  self.abstract_class = true

  class << self
    def all
      subclasses.map(&:all).flatten
    end
  end
end