class CreateSpreeListings < ActiveRecord::Migration
  def change
    create_table :spree_listings do |t|
      t.integer :stockpile_id
      t.integer :shop_id
      t.integer :address_id
      t.integer :days_to_refresh
      t.datetime :available_on
      t.datetime :expires_on
      t.datetime :deleted_at

      t.timestamps
    end
    add_index :spree_listings, [:shop_id]
    add_index :spree_listings, [:address_id]
  end
end
