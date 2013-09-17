class CreateSpreeTransportationPrices < ActiveRecord::Migration
  def change
    create_table :spree_transportation_prices do |t|
      t.integer :price_id
      t.integer :address_id
      t.string :terms

      t.timestamps
    end
  end
end
