Spree::Sample.load_sample("users")
Spree::Sample.load_sample("addresses")

user = Spree::User.find_by_email! "admin@thomaschen.co"
address = Spree::Address.find_by_nickname! "Admin Shop"
::Spree::Shop.create!(
  user: user,
  name: "Admin Shop",
  email: "shop@thomaschen.co",
  address: address)