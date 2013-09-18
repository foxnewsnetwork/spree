Spree::Sample.load_sample("products")
Spree::Sample.load_sample("variants")

products = {}
products[:ror_baseball_jersey] = Spree::Product.find_by_name! "PET Milk Jug"
products[:ror_tote] = Spree::Product.find_by_name! "HDPE Foam"
products[:ror_bag] = Spree::Product.find_by_name! "PVK Film"
products[:ror_jr_spaghetti] = Spree::Product.find_by_name! "Mixed Rigid Plastics"
products[:ror_mug] = Spree::Product.find_by_name! "PVC Piping"
products[:ror_ringer] = Spree::Product.find_by_name! "PS Foam"
products[:ror_stein] = Spree::Product.find_by_name! "PP Regrind"
products[:spree_baseball_jersey] = Spree::Product.find_by_name! "LDPE Shopping Bags"
products[:spree_stein] = Spree::Product.find_by_name! "HDPE Shampoo Bottles"
products[:spree_jr_spaghetti] = Spree::Product.find_by_name! "PLA bottles"

def image(name, type="jpeg")
  images_path = Pathname.new(File.dirname(__FILE__)) + "images"
  path = images_path + "#{name}.#{type}"
  return false if !File.exist?(path)
  File.open(path)
end

images = {
  products[:ror_tote].master => [
    {
      :attachment => image("ror_tote")
    },
    {
      :attachment => image("ror_tote_back") 
    }
  ],
  products[:ror_bag].master => [
    {
      :attachment => image("ror_bag")
    }
  ],
  products[:ror_baseball_jersey].master => [
    {
      :attachment => image("ror_baseball")
    },
    {
      :attachment => image("ror_baseball_back")
    }
  ],
  products[:ror_jr_spaghetti].master => [
    {
      :attachment => image("ror_jr_spaghetti")
    }
  ],
  products[:ror_mug].master => [
    {
      :attachment => image("ror_mug")
    },
    {
      :attachment => image("ror_mug_back")
    }
  ],
  products[:ror_ringer].master => [
    {
      :attachment => image("ror_ringer")
    },
    {
      :attachment => image("ror_ringer_back")
    }
  ],
  products[:ror_stein].master => [
    {
      :attachment => image("ror_stein")
    },
    {
      :attachment => image("ror_stein_back")
    }
  ],
  products[:spree_jr_spaghetti].master => [
    {
      :attachment => image("spree_spaghetti")
    }
  ],
  products[:spree_baseball_jersey].master => [
    {
      :attachment => image("spree_jersey")
    },
    {
      :attachment => image("spree_jersey_back") 
    }
  ],
  products[:spree_stein].master => [
    {
      :attachment => image("spree_stein")
    },
    {
      :attachment => image("spree_stein_back") 
    }
  ]
}

products[:ror_baseball_jersey].variants.each do |variant|
  color = variant.option_value("tshirt-color").downcase
  main_image = image("ror_baseball_jersey_#{color}", "png")
  variant.images.create!(:attachment => main_image)
  back_image = image("ror_baseball_jersey_back_#{color}", "png")
  if back_image
    variant.images.create!(:attachment => back_image)
  end
end

images.each do |variant, attachments|
  puts "Loading images for #{variant.name}"
  attachments.each do |attachment|
    variant.images.create!(attachment)
  end
end

