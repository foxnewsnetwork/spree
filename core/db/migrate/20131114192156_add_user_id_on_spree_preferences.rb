class AddUserIdOnSpreePreferences < ActiveRecord::Migration
  def change
    add_column :spree_preferences, :user_id, :integer
    add_index :spree_preferences, [:user_id]
  end
end
