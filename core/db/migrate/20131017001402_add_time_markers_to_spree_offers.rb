class AddTimeMarkersToSpreeOffers < ActiveRecord::Migration
  def change
    add_column :spree_offers, :deleted_at, :datetime
    add_column :spree_offers, :expires_at, :datetime
  end
end
