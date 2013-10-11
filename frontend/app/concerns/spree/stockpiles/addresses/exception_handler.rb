class Spree::Stockpiles::Addresses::ExceptionHandler
  def initialize(exception)
    @exception = exception
  end

  def flash_message
    return _default_message if _validation_error?
  end

  def user_input_error?
    _validation_error? && _default_message =~ /validation failed/i
  end

  private

  def _validation_error?
    @exception.is_a? ActiveRecord::RecordInvalid
  end

  def _default_message
    @exception.message
  end
end