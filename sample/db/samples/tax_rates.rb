north_america = Spree::Zone.find_by_name!("North America")
international_trade = Spree::TaxCategory.find_by_name!("International Trade")
tax_rate = Spree::TaxRate.create(
  :name => "North America",
  :zone => north_america, 
  :amount => 0,
  :tax_category => international_trade)
tax_rate.calculator = Spree::Calculator::DefaultTax.create!
tax_rate.save!
