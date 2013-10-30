class Spree::Finalizations::Serviceables::Ships::FormHelper
  include ActiveModel::Validations
  Fields = [
    :origination_port_code,
    :destination_port_code,
    :carrier_name,
    :depart_at,
    :arrive_at,
    :cutoff_at,
    :return_at,
    :usd_price
  ]
  attr_hash_accessor *Fields

  validates_with Spree::Finalizations::Serviceables::Ships::CausalityValidator

  class << self
    def model_name
      ActiveModel::Name.new self, nil, "serviceable"
    end
  end

  def to_key
    nil
  end

  def to_param
    nil
  end

  def to_partial_path
    'finalizations/serviceables/ships'
  end

  def persisted?
    false
  end

  def initialize(attributes={})
    @attributes = attributes
  end

  def ship_serviceable_params
    @attributes
  end
end