class CreateSpreeShops < ActiveRecord::Migration
  def change
    create_table :spree_shops do |t|
      t.integer :user_id
      t.string :name
      t.timestamps
    end
  end
end
