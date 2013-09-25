class CreateSpreeMaterials < ActiveRecord::Migration
  def change
    create_table :spree_materials do |t|
      t.string :name
      t.text :description
      t.string :permalink, :null => false
      t.datetime :deleted_at

      t.timestamps
    end
    add_index :spree_materials, [:permalink], :unique => true
  end
end
