class Spree::Offers::EditFormHelper
  include ActiveModel::Validations

  validates_with Spree::Countries::Validator
  validates_with Spree::States::Validator
  validates_with Spree::Addresses::Validator
  validates :address1, :city, :country, presence: true
  validates :transport_method, 
    presence: true,
    inclusion: { in: Spree::Offer::TransportMethods }
  validates :usd_per_pound,
    presence: true,
    numericality: { greater_than: 0 }
  validates :shipping_terms,
    presence: true,
    inclusion: { in: Spree::Offer::Terms }

  attr_accessor *Spree::Offers::ParamsProcessor::AllFields

  class << self
    def model_name
      ActiveModel::Name.new self, nil, "offer"
    end
  end

  def initialize(attributes={})
    @attributes = attributes
  end

  def read_attribute_for_validation(key)
    @attributes[key]
  end

  def persisted?
    false
  end

  def to_key
    _offer.to_key if persisted?
  end

  def to_param
    nil
  end

  def to_partial_path
    "spree/offers/edit_form"
  end

  def offer_params
    Spree::Offers::ParamsProcessor.new(@attributes).offer_params
  end

end