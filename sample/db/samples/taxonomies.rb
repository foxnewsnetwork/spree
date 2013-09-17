taxonomies = [
  { :name => "Materials" },
  { :name => "Locations" },
  { :name => "Companies" }
]

taxonomies.each do |taxonomy_attrs|
  Spree::Taxonomy.create!(taxonomy_attrs)
end
