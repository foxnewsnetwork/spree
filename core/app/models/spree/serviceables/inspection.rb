class Spree::Serviceables::Inspection < Spree::Serviceable
  self.table_name = 'spree_serviceables_inspections'
  acts_as_paranoid

  has_many :images
    as: :viewable,
    dependent: :destroy,
    class_name: 'Spree::Image'
end