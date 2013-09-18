class AddAddressIdToVariants < ActiveRecord::Migration
  def change
    add_column :spree_variants, :address_id, :integer
    add_index :spree_variants, ['address_id']
  end
end
