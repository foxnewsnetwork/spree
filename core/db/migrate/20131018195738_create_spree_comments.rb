class CreateSpreeComments < ActiveRecord::Migration
  def change
    create_table :spree_comments do |t|
      t.references :offer
      t.references :shop
      t.text :content, null: false
      t.datetime :deleted_at
      t.timestamps
    end
  end
end
