class CreateOrders < ActiveRecord::Migration
  def self.up
    create_table :orders do |t|
      t.string :first_name
      t.string :last_name
      t.string :store
      t.string :address1
      t.string :address2
      t.string :city
      t.string :state
      t.integer :zip
      t.string :email
      t.boolean :opt_in

      t.timestamps
    end
  end

  def self.down
    drop_table :orders
  end
end
