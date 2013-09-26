taxonomies = [
  { :name => "Categories" },
  { :name => "Company" },
  { :name => "Location" },
  { :name => "Process State" },
  { :name => "Packaging" }
]

taxonomies.each do |taxonomy_attrs|
  Spree::Taxonomy.create!(taxonomy_attrs)
end
