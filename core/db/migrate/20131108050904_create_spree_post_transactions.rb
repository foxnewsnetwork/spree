class CreateSpreePostTransactions < ActiveRecord::Migration
  def change
    create_table :spree_post_transactions do |t|
      t.references :finalization, index: true
      t.datetime :closed_at
      t.datetime :deleted_at

      t.timestamps
    end
  end
end
