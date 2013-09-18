Spree::Sample.load_sample("tax_categories")
Spree::Sample.load_sample("shipping_categories")
Spree::Sample.load_sample("users")
Spree::Sample.load_sample("shops")

business = Spree::TaxCategory.find_by_name!("International Trade")
shipping_category = Spree::ShippingCategory.find_by_name!("Default Shipping")
default_attrs = {
  :description => Faker::Lorem.paragraph,
  :available_on => Time.zone.now
}

products = [
  {
    :name => "PET Milk Jug",
    :tax_category => business,
    :shipping_category => shipping_category,
    :price => 0.015
  },
  {
    :name => "HDPE Foam",
    :tax_category => business,
    :shipping_category => shipping_category,
    :price => 0.01
  },
  {
    :name => "PVK Film",
    :tax_category => business,
    :shipping_category => shipping_category,
    :price => 0.025
  },
  {
    :name => "Mixed Rigid Plastics",
    :tax_category => business,
    :shipping_category => shipping_category,
    :price => 0.007

  },
  {
    :name => "PVC Piping",
    :shipping_category => shipping_category,
    :tax_category => business,
    :price => 0.008
  },
  {
    :name => "PS Foam",
    :tax_category => business,
    :shipping_category => shipping_category,
    :price => 0.011
  },
  {
    :name => "PP Regrind",
    :tax_category => business,
    :shipping_category => shipping_category,
    :price => 0.021
  },
  {
    :name => "LDPE Shopping Bags",
    :tax_category => business,
    :shipping_category => shipping_category,
    :price => 0.005
  },
  {
    :name => "HDPE Shampoo Bottles",
    :tax_category => business,
    :shipping_category => shipping_category,
    :price => 0.018
  },
  {
    :name => "PLA bottles",
    :tax_category => business,
    :shipping_category => shipping_category,
    :price => 0.023
  }
]

user = Spree::User.find_by_email! "dev@thomaschen.co"
shop = Spree::Shop.find_by_user_id! user.id
products.each do |product_attrs|
  Spree::Config[:currency] = "USD"
  default_shipping_category = Spree::ShippingCategory.find_by_name!("Default Shipping")
  product = shop.products.create! default_attrs.merge product_attrs
  product.save!
end

Spree::Config[:currency] = "USD"
