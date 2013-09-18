class AddShopIdToProducts < ActiveRecord::Migration
  def change
    add_column :spree_products, :shop_id, :integer
    add_index :spree_products, ['shop_id']
  end
end
