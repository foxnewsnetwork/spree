class Spree::Listings::FormHelper
  class MaterialValidator < ActiveModel::Validator
    def validate(model)
      if Spree::Material.find_by_id(model.read_attribute_for_validation :material).blank?
        model.errors.add :material, "#{model.read_attribute_for_validation :material} doesn't exist"
      end
    end
  end
  class WeightValidator < ActiveModel::Validator

  end
  include ActiveModel::Validations
  attr_accessor :material,
    :origin_products,
    :pounds_on_hand,
    :packaging,
    :process_state,
    :available_on,
    :expires_on,
    :notes
  validates_presence_of :material, :origin_products
  validates :pounds_on_hand, numericality: { greater_than: 0, only_integer: true }, presence: true
  validates_with MaterialValidator

  def flash_message
    _handler.flash_message
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

  def to_partial_path
    Spree.r.listings_path
  end

  def to_param
    nil
  end

  def stockpile_params
    Spree::Listings::StockpileParamsProcessor.new(@attributes).stockpile_params
  end

  def to_key
    nil
  end

  private

  def _handler
    @handler ||= Spree::Listings::ExceptionHandler.new(valid? || errors)
  end

end