class CreateSpreeOffers < ActiveRecord::Migration
  def change
    create_table :spree_offers do |t|
      t.integer :user_id
      t.integer :price_id
      t.datetime :expires_on

      t.timestamps
    end
    add_index :spree_offers, [:price_id]
    add_index :spree_offers, [:user_id]
  end
end
