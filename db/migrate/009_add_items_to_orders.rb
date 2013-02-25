class AddItemsToOrders < ActiveRecord::Migration
  def self.up
    add_column :orders, :purchaser_type, :string
    add_column :orders, :eula, :boolean
    add_column :orders, :review_url, :string
    add_column :orders, :phone, :string
  end

  def self.down
    remove_column :orders, :purchaser_type
    remove_column :orders, :eula
    remove_column :orders, :review_url
    remove_column :orders, :phone
  end
end
