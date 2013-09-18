Spree::Sample.load_sample("taxonomies")
Spree::Sample.load_sample("products")

materials = Spree::Taxonomy.find_by_name!("Materials")
brands = Spree::Taxonomy.find_by_name!("Companies")

products = { 
  :pet_milk_jug => "PET Milk Jug"
  :hdpe_foam => "HDPE Foam"
  :pvk_film => "PVK Film"
  :mixed_rigid_plastics => "Mixed Rigid Plastics"
  :pvc_piping => "PVC Piping"
  :ps_foam => "PS Foam"
  :pp_regrind => "PP Regrind"
  :ldpe_shopping_bags => "LDPE Shopping Bags"
  :hdpe_shampoo_bottles => "HDPE Shampoo Bottles"
  :pla_bottles => "PLA bottles"
}


products.each do |key, name|
  products[key] = Spree::Product.find_by_name!(name)
end

taxons = [
  {
    :name => "Materials",
    :taxonomy => materials,
    :position => 0
  },
  {
    :name => "Other",
    :taxonomy => materials,
    :parent => "Materials",
    :position => 2,
    :products => [
      products[:mixed_rigid_plastics],
      products[:pvk_film],
      products[:pla_bottles]
    ]
  },
  {
    :name => "Polyethylene",
    :taxonomy => materials,
    :parent => "Materials",
    :position => 1,
    :products => [
      products[:pet_milk_jug]
    ]
  },
  {
    :name => "High Density Polyethylene",
    :taxonomy => materials,
    :parent => "Materials",
    :position => 2,
    :products => [
      products[:hdpe_foam],
      products[:hdpe_shampoo_bottles]
    ]
  },
  {
    :name => "Low Density Polyethylene",
    :taxonomy => materials,
    :parent => "Materials",
    :position => 3,
    :products => [
      products[:ldpe_shopping_bags]
    ]  
  },
  {
    :name => "Polystyrene",
    :taxonomy => materials,
    :parent => "Materials"
    :products => [
      products[:ps_foam]
    ]
  },
  {
    :name => "Polyvinyl Chloride",
    :taxonomy => materials,
    :parent => "Materials",
    :position => 0,
    :products => [
      products[:pvc_piping]
    ]
  },
  {
    :name => "Polypropylene",
    :taxonomy => materials,
    :parent => "Materials" ,
    :products => [
      products[:pp_regrind]
    ],
    :position => 0
  },
  {
    :name => "companies",
    :taxonomy => companies
  },
  {
    :name => "Thomas Chen Co.",
    :taxonomy => companies,
    :parent => "companies"
    :products => products 
  },
  {
    :name => "ML Resources Inc.",
    :taxonomy => companies,
    :parent => "companies" 
  },
  {
    :name => "Acme Inc.",
    :taxonomy => companies,
    :parent => "companies"
  },
  {
    :name => "37 Signals",
    :taxonomy => companies,
    :parent => "companies"
  },
]

taxons.each do |taxon_attrs|
  if taxon_attrs[:parent]
    taxon_attrs[:parent] = Spree::Taxon.find_by_name!(taxon_attrs[:parent])
    Spree::Taxon.create!(taxon_attrs)
  end
end
