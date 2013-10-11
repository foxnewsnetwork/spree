module Spree
  class Stockpile < ActiveRecord::Base
    belongs_to :material, :class_name => 'Spree::Material'
    belongs_to :address, :class_name => 'Spree::Address'
    has_one :listing, :class_name => 'Spree::Listing'
    has_one :shop, :class_name => 'Spree::Shop', through: :listing
    has_and_belongs_to_many :option_values, 
      join_table: :spree_option_values_stockpiles
    has_many :images, 
      -> { order(:position) }, 
      as: :viewable, 
      dependent: :destroy, 
      class_name: "Spree::Image"

    has_many :variant_images, 
      -> { order(:position) }, 
      as: :viewable, 
      dependent: :destroy, 
      class_name: "Spree::Image"

    has_many :origin_relationships,
      class_name: 'Spree::OriginProductsStockpiles',
      dependent: :destroy

    has_many :origin_products,
      through: :origin_relationships

    delegate :available_on, :expires_on, :seller_offer, :offers, :to => :listing

    validates :pounds_on_hand, numericality: { greater_than_or_equal_to: 0 }, presence: true

    def came_from!(origin_product)
      origin_relationships.create! origin_product: origin_product
    end

    def container_weight
      4000
    end

    def require_shop?
      shop.blank?
    end

    def require_address?
      address.blank?
    end

    def containers_on_hand
      pounds_on_hand / container_weight unless container_weight.nil?
    end

    def name
      @name ||= "#{material.name} #{_origin_product_names} #{_option_value_names}"
    end

    def image_name
      "plastic-#{material.name}".downcase
    end

    def full_description
      notes
    end

    def properties
      @properties ||= option_values.to_a.uniq_merge do |option_value|
        option_value.option_type_id
      end.call do |mem,nex|
        if mem.is_a? Array
          mem << nex
        else
          [mem] << nex
        end
      end.map do |a|
        if a.is_a? Array
          a
        else
          [a]
        end
      end
    end

    private

    def _origin_product_names
      origin_products.map(&:presentation).sort.join " "
    end

    def _option_value_names
      option_values.map(&:presentation).sort.join " "
    end
  end
end
