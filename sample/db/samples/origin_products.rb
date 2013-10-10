Spree::Sample.load_sample("stockpiles")

origin_products = [
  { presentation: 'Milk Jugs' },
  { presentation: 'Credit Cards' },
  { presentation: 'Water Bottles' },
  { presentation: 'Shampoo Bottles' }
]

Spree::OriginProduct.create! origin_products
ops = Spree::OriginProduct.all

Spree::Stockpile.all.each do |stockpile|
  stockpile.came_from! ops.random
end