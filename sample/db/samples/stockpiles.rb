Spree::Sample.load_samples("materials")
Spree::Sample.load_samples("addresses")
Spree::Sample.load_sample("option_values")

shop_address = Spree::Address.find_by_nickname! "Admin Shop"
packages = Spree::OptionType.find_by_presentation!("Packaging").option_values
proccesses = Spree::OptionType.find_by_presentation!("Process State").option_values

def rand_subarray(array)
  s = rand array.count
  f = array.count - s
  array.slice(s, f).to_a
end

Materials.all.each do |material|
  attributes = {
    material: material,
    address: shop_address,
    option_values: rand_subarray(proccesses) + rand_subarray(packages),
    pounds_on_hand: rand(345455),
    cost_price_per_pound: rand(32)
  }
  Spree::Stockpile.create! attributes
end