module Spree
  class State < ActiveRecord::Base
    belongs_to :country, class_name: 'Spree::Country'

    validates :country, :name, presence: true

    class << self
      def normalize(whatever)
        return whatever if whatever.is_a? self.class
        return find_by_id(whatever) if whatever.is_a? Integer
        return find_all_by_name_or_abbr whatever
      end

      def find_all_by_name_or_abbr(name_or_abbr)
        where('name = ? OR abbr = ?', name_or_abbr, name_or_abbr)
      end

      def all_names
        @_everybody ||= select("distinct name").map(&:name).sort.uniq
      end

      # table of { country.id => [ state.id , state.name ] }, arrays sorted by name
      # blank is added elsewhere, if needed
      def states_group_by_country_id
        state_info = Hash.new { |h, k| h[k] = [] }
        self.order('name ASC').each { |state|
          state_info[state.country_id.to_s].push [state.id, state.name]
        }
        state_info
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
