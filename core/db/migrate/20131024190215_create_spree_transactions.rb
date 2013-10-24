class CreateSpreeTransactions < ActiveRecord::Migration
  def change
    create_table :spree_transactions do |t|
      t.references :offer, index: true
      t.datetime :expires_at
      t.datetime :deleted_at

      t.timestamps
    end
  end
end
