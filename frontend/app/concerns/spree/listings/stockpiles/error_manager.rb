class Spree::Listings::Stockpiles::ErrorManager
  def initialize(exception)
    @exception = exception
  end

  def bad_user_input?
    _bad_material? || _bad_weight?
  end

  def flash_message
    return _material_message if _bad_material?
    return _packaging_message if _bad_packaging?
    return _origin_message if _bad_origin?
    return _weight_message if _bad_weight?
    _default_message
  end

  private

  def _packaging_message
    Spree.t(:you_need_to_select_a_valid_packaging_method)
  end

  def _bad_packaging?
    _invalid_input? && _default_message =~ /packag/
  end

  def _invalid_input?
    @exception.is_a? Spree::InvalidInput
  end

  def _origin_message
    Spree.t(:you_are_required_to_select_or_input_in_what_original_product_your_material_was)
  end

  def _bad_origin?
    _invalid_input? && _default_message =~ /origin/
  end

  def _default_message
    @exception.message
  end

  def _bad_weight?
    _invalid_record? && @exception.message =~ /pounds on hand/i
  end

  def _weight_message
    _default_message.gsub(/pounds on hand/i, "Weight") + ". Also, make sure you're using pounds."
  end

  def _invalid_record?
    @exception.is_a?(ActiveRecord::RecordInvalid)
  end

  def _bad_material?
    @exception.message =~ /Couldn't find Spree::Material without an ID/
  end

  def _material_message
    Spree.t(:you_need_to_gave_a_valid_plastic_material)
  end


end