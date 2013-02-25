class BooksOrders < ActiveRecord::Migration
  def self.up
    create_table :books_orders, :id => false do |t|
      t.integer :book_id
      t.integer :order_id
      
      t.timestamps
    end
  end

  def self.down
     drop_table :books_orders
  end

end
