class CreateSpreeShops < ActiveRecord::Migration
  def change
    create_table :spree_shops do |t|
      t.integer :user_id
      t.datetime :deleted_at
      t.string :email
      t.integer :address_id

      t.timestamps
    end
  end
end
