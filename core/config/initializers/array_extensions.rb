class Array
  def uniq_merge(&block)
    lambda do |&merge_together|
      inject({}) do |hash, element|
        (hash[yield element] ||= []) << element
        hash
      end.to_a.map(&:last).inject(self.class.new) do |array, els|
        array.push els.reduce(&merge_together)
      end
    end
  end

end