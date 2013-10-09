module Spree
  class Country < ActiveRecord::Base
    has_many :states, -> { order('name ASC') }

    validates :name, :iso_name, presence: true

    class << self
      def normalize(whatever)
        return whatever if whatever.is_a? self.class
        return find_all_by_name_or_iso_name(whatever.to_s).first || find_by_id(whatever.to_i)
      end

      def find_all_by_name_or_iso_name(name)
        where('name = ? OR iso_name = ?', name, name)
      end

      def all_names
        @_everybody ||= select("distinct name").map(&:name).sort.uniq.unshift "United States"
      end

      def states_required_by_country_id
        states_required = Hash.new(true)
        all.each { |country| states_required[country.id.to_s]= country.states_required }
        states_required
      end
    end

    def <=>(other)
      name <=> other.name
    end

    def to_s
      name
    end
  end
end
