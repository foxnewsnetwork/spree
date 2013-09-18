class AddAddressInfoToPrices < ActiveRecord::Migration
  def change
    add_column :spree_prices, :address_id, :integer
    add_index :spree_prices, ['address_id']
    add_column :spree_prices, :terms, :string, :null => false, :default => "EXWORK"
  end
end
