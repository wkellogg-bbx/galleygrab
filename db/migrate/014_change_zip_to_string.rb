class ChangeZipToString < ActiveRecord::Migration
  def self.up
    change_column :orders, :zip, :string
  end

  def self.down
    change_column :orders, :zip, :integer
  end
end
