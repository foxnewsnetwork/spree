Spree::Sample.load_sample("products")

grade = Spree::OptionType.find_by_presentation!("Grade")
color = Spree::OptionType.find_by_presentation!("Color")

ror_baseball_jersey = Spree::Product.find_by_name!("HDPE Foam")
ror_baseball_jersey.option_types = [grade, color]
ror_baseball_jersey.save!

spree_baseball_jersey = Spree::Product.find_by_name!("PS Foam")
spree_baseball_jersey.option_types = [size, color]
spree_baseball_jersey.save!
