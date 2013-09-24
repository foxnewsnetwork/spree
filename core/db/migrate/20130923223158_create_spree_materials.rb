class CreateSpreeMaterials < ActiveRecord::Migration
  def change
    create_table :spree_materials do |t|
      t.string :name
      t.text :description
      t.string :permalink
      t.datetime :deleted_at

      t.timestamps
    end
  end
end
