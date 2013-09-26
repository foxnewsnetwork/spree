Spree::Sample.load_sample("taxonomies")
Spree::Sample.load_sample("products")
Spree::Sample.load_sample("stockpiles")
Spree::Sample.load_sample("listings")

categories = Spree::Taxonomy.find_by_name!("Categories")
companies = Spree::Taxonomy.find_by_name!("Company")
locations = Spree::Taxonomy.find_by_name! "Location"
processes = Spree::Taxonomy.find_by_name! "Process State"
packages = Spree::Taxonomy.find_by_name! "Packaging"


taxons = [
  {
    name: "Categories",
    taxonomy: categories,
    position: 0
  },
  {
    name: "Company",
    taxonomy: companies
  },
  {
    name: "Location",
    taxonomy: locations
  },
  {
    name: "Process State", 
    taxonomy: processes
  },
  {
    name: "Packaging", 
    taxonomy: packages
  }
]

taxons += Spree::Stockpile.all.map do |stockpile|
  {
    name: stockpile.material.name,
    taxonomy: categories,
    parent: "Categories",
    position: 1,
    stockpiles: [stockpile]
  }
end

taxons += Spree::Listing.all.map do |listing|
  {
    name: listing.shop.name,
    taxonomy: companies,
    parent: "Company",
    position: 2,
    stockpiles: [listing.stockpile]
  }
end.uniq_merge do |hash|
  hash[:name]
end.call do |a,b|
  a[:stockpiles] += b[:stockpiles]
  a
end

taxons += Spree::Listing.all.map do |listing|
  {
    name: listing.address.permalink_name,
    taxonomy: locations,
    parent: "Location",
    position: 3,
    stockpiles: [listing.stockpile]
  }
end.uniq_merge do |hash|
  hash[:name]
end.call do |a,b|
  a[:stockpiles] += b[:stockpiles]
  a
end

statement = ["presentation = ? or presentation = ?", 'Packaging', 'Process State']
taxons += Spree::OptionType.where(*statement).map(&:option_values).flatten.map do |option_value|
  p = option_value.option_type.presentation == "Packaging" ? packages : processes
  {
    name: option_value.name,
    taxonomy: p,
    parent: p.name,
    position: 4,
    stockpiles: option_value.stockpiles
  }
end

taxons.each do |taxon_attrs|
  if taxon_attrs[:parent]
    begin
      taxon_attrs[:parent] = Spree::Taxon.find_by_name!(taxon_attrs[:parent])
      Spree::Taxon.create!(taxon_attrs)
    rescue ActiveRecord::RecordNotFound => e
      puts taxon_attrs[:parent]      
    end

  end
end
