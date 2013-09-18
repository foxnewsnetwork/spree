Spree::Sample.load_sample("option_values")
Spree::Sample.load_sample("products")
Spree::Sample.load_sample("addresses")

hdpe_foam = Spree::Product.find_by_name! "HDPE Foam"

address = Spree::Address.find_by_nickname! "Riverstar Yard"

grade_a = Spree::OptionValue.find_by_name!("Grade A")
grade_b = Spree::OptionValue.find_by_name!("Grade B")
grade_c = Spree::OptionValue.find_by_name!("Grade C")
grade_d = Spree::OptionValue.find_by_name!("Grade D")

red = Spree::OptionValue.find_by_name!("Red")
blue = Spree::OptionValue.find_by_name!("Blue")
green = Spree::OptionValue.find_by_name!("Green")

variants = [
  {
    :product => hdpe_foam,
    :option_values => [grade_a, red],
    :sku => "HDPE-00001",
    :cost_price => 0.01,
    :location => address
  },
  {
    :product => hdpe_foam,
    :option_values => [grade_a, blue],
    :sku => "HDPE-00002",
    :cost_price => 0.009,
    :location => address
  },
  {
    :product => hdpe_foam,
    :option_values => [grade_a, green],
    :sku => "HDPE-00003",
    :cost_price => 0.011,
    :location => address
  },
  {
    :product => hdpe_foam,
    :option_values => [grade_b, red],
    :sku => "HDPE-00004",
    :cost_price => 0.01,
    :location => address
  },
  {
    :product => hdpe_foam,
    :option_values => [grade_b, blue],
    :sku => "HDPE-00005",
    :cost_price => 0.01,
    :location => address
  },
  {
    :product => hdpe_foam,
    :option_values => [grade_b, green],
    :sku => "HDPE-00006",
    :cost_price => 0.01,
    :location => address
  },
  {
    :product => hdpe_foam,
    :option_values => [grade_c, red],
    :sku => "HDPE-00007",
    :cost_price => 0.01,
    :location => address
  },
  {
    :product => hdpe_foam,
    :option_values => [grade_c, blue],
    :sku => "HDPE-00008",
    :cost_price => 0.01,
    :location => address
  },
  {
    :product => hdpe_foam,
    :option_values => [grade_c, green],
    :sku => "HDPE-00009",
    :cost_price => 0.01,
    :location => address
  },
  {
    :product => hdpe_foam,
    :option_values => [grade_d, green],
    :sku => "HDPE-00012",
    :cost_price => 0.01,
    :location => address
  },
]

Spree::Variant.create!(variants)

