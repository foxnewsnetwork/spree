module Spree
  class Material < ActiveRecord::Base
    acts_as_paranoid
    has_many :stockpiles, class_name: 'Spree::Stockpile'
    has_many :images, 
      -> { order(:position) }, 
      as: :viewable, 
      dependent: :destroy, 
      class_name: "Spree::Image"
    make_permalink order: :name
    validates :name, presence: true
    validates :permalink, presence: true

    before_destroy :_punch_permalink

    class << self
      def all_as_options_array
        @_all_as_options_array ||= all.map(&:to_options_array)
      end
    end

    def to_options_array
      [name, id]
    end

    private
    def _punch_permalink
      update_attribute :permalink, "#{Time.now.to_i}_#{permalink}" # punch permalink with date prefix
    end
  end
end
