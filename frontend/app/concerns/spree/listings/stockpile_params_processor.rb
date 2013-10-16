class Spree::Listings::StockpileParamsProcessor

  def initialize(params)
    @params = params
  end
  

  def stockpile_params
    @stockpile_params ||= _processed_stockpile_params.tap do |hash|
      hash[:option_values] = [:packaging, :process_state].map do |key| 
        hash.delete(key)
      end.reject(&:blank?)
    end
  end

  private


  def _processed_stockpile_params
    @params.tap do |hash|
      hash[:material] = Spree::Material.find hash[:material]
    end.access_map! :packaging, :process_state do |id|
      Spree::OptionValue.normalize! id
    end.access_map! :origin_products do |presentations|
      _origin_products_from_presentations presentations
    end
  end

  def _origin_products_from_presentations(presentations)
    _arrayify(presentations).map { |presentation| _origin_product_from_presentation presentation }
  end

  def _arrayify(string_or_array)
    return string_or_array if string_or_array.is_a? Array
    string_or_array.split(",").map(&:strip).reject(&:blank?)
  end

  def _origin_product_from_presentation(presentation)
    Spree::OriginProduct.find_by_permalink_but_create_by_presentation!(presentation)
  end
end