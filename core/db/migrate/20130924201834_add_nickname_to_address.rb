class AddNicknameToAddress < ActiveRecord::Migration
  def change
    add_column :spree_addresses, :nickname, :string
  end
end
