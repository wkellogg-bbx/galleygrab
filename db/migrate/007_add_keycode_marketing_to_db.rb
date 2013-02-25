class AddKeycodeMarketingToDb < ActiveRecord::Migration
  def self.up
    change_column :books, :isbn_13, :string
    add_column :books, :marketing, :text
    add_column :orders, :keycode, :string
 
  end

  def self.down
    remove_column :books, :isbn_13
    remove_column :books, :marketing
    remove_column :orders, :keycode
  end
end
