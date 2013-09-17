user = User.find_by_email! "dev@thomaschen.co"
shop = user.shop.create! :name => "Thomas Chen Shop"
User.all.each do |employee|
  shop.employs! employee
end