user = Spree::User.find_by_email! "dev@thomaschen.co"
shop = user.shop.create! :name => "Thomas Chen Shop"
