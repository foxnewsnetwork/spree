class Spree::InvalidInput < StandardError
  attr_accessor :message
  def initialize(e)
    super(e)
    self.message = "Invalid input for #{e.to_s}"
  end
end