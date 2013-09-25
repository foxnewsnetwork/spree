module Spree
  class Material < ActiveRecord::Base
    acts_as_paranoid
    has_many :stockpiles, class_name: 'Spree::Stockpile'

    make_permalink order: :name
    validates :name, presence: true
    validates :permalink, presence: true

    before_destroy :_punch_permalink

    private
    def _punch_permalink
      update_attribute :permalink, "#{Time.now.to_i}_#{permalink}" # punch permalink with date prefix
    end
  end
end
