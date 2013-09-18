Spree::Sample.load_sample("variants")

Spree::Variant.all.each do |variant|
  variant.stock_quantity.restock! rand 100000
  variant.stock_quantity.start_on! 1.day.ago
  variant.stock_quantity.end_on! 1.week.from_now
end
