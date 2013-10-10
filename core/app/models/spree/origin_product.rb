class Spree::OriginProduct < ActiveRecord::Base
  acts_as_paranoid
  has_many :origin_relationships, 
    class_name: 'Spree::OriginProductsStockpiles',
    dependent: :destroy
  has_many :stockpiles,
    through: :origin_products_stockpiles,
    class_name: 'Spree::Stockpile'

  validates :permalink, presence: true
  validates :presentation, presence: true
  before_validation :_set_permalink
  before_destroy :_punch_permalink
  private

  def _set_permalink
    self.name = self.name.split(" ").reject(&:blank?).map(&:singularize).map(&:downcase).join
  end

  def _punch_permalink
    update_attribute :permalink, "#{Time.now.to_i}_#{permalink}" # punch permalink with date prefix
  end
end
