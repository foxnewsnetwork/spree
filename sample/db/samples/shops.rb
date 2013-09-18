user = Spree::User.find_by_email! "dev@thomaschen.co"
shop = Spree::Shop.create!( 
  :name => "Thomas Chen Shop",
  :owner => user)
