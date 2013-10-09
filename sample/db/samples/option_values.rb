Spree::Sample.load_sample("option_types")

size = Spree::OptionType.find_by_presentation!("Size")
color = Spree::OptionType.find_by_presentation!("Color")


Spree::OptionValue.create!([
  {
    :name => "Small",
    :presentation => "S",
    :position => 1,
    :option_type => size
  },
  {
    :name => "Medium",
    :presentation => "M",
    :position => 2,
    :option_type => size
  },
  {
    :name => "Large",
    :presentation => "L",
    :position => 3,
    :option_type => size
  },
  {
    :name => "Extra Large",
    :presentation => "XL",
    :position => 4,
    :option_type => size
  },
  {
    :name => "Red",
    :presentation => "Red",
    :position => 1,
    :option_type => color,
  },
  {
    :name => "Green",
    :presentation => "Green",
    :position => 2,
    :option_type => color,
  },
  {
    :name => "Blue",
    :presentation => "Blue",
    :position => 3,
    :option_type => color
  }
])

process = Spree::OptionType.find_by_presentation! "Process State"
packaging = Spree::OptionType.find_by_presentation! "Packaging"
origin = Spree::OptionType.find_by_presentation! "Origin Product"

Spree::OptionValue.create!([
  {
    name: 'laptop',
    presentation: 'Laptops',
    option_type: origin
  },
  {
    name: 'creditcard',
    presentation: 'Credit Cards',
    option_type: origin
  },
  {
    name: "milkjug",
    presentation: "Milk Jugs",
    option_type: origin
  },
  {
    name: "Supersacks",
    presentation: "Supersacks",
    option_type: packaging
  },
  {
    name: "No packaging",
    presentation: "No packaging",
    option_type: packaging
  },
  {
    name: "Gaylord",
    presentation: "Gaylord",
    option_type: packaging
  },
  {
    name: "Pallet",
    presentation: "Pallet",
    option_type: packaging
  },
  {
    name: "Baled",
    presentation: "Baled",
    option_type: packaging
  },
  {
    name: "Hotwashed",
    presentation: "Hot washed",
    option_type: process
  },
  {
    name: "Reground",
    presentation: "Regrind",
    option_type: process
  },
  {
    name: "Condensed",
    presentation: "Condensed",
    option_type: process
  }
])