Spree::Sample.load_sample("materials")
Spree::Sample.load_sample("addresses")
Spree::Sample.load_sample("option_values")

shop_address = Spree::Address.find_by_nickname! "Admin Shop"
packages = Spree::OptionType.find_by_presentation!("Packaging").option_values
proccesses = Spree::OptionType.find_by_presentation!("Process State").option_values

def random_access(array)
  array[rand(array.length)]
end

Spree::Material.all.each do |material|
  attributes = {
    material: material,
    address: shop_address,
    option_values: [random_access(proccesses), random_access(packages)],
    pounds_on_hand: rand(345455),
    cost_usd_per_pound: rand(32),
    notes: Faker::Lorem.paragraph
  }
  Spree::Stockpile.create! attributes
end
