module Spree
  class Country < ActiveRecord::Base
    has_many :states, -> { order('name ASC') }

    validates :name, :iso_name, presence: true

    def self.all_names
      @_everybody ||= select("distinct name").map(&:name).sort.uniq.unshift "United States"
    end

    def self.states_required_by_country_id
      states_required = Hash.new(true)
      all.each { |country| states_required[country.id.to_s]= country.states_required }
      states_required
    end

    def <=>(other)
      name <=> other.name
    end

    def to_s
      name
    end
  end
end
