class CreateBooks < ActiveRecord::Migration
  def self.up
    create_table :books do |t|
      t.string :title
      t.string :subtitle
      t.string :author
      t.date :pubdate
      t.float :us_price
      t.float :can_price
      t.string :isbn_13
      t.text :short_descrip
      t.text :long_descrip
      t.integer :position

      t.timestamps
    end
  end

  def self.down
    drop_table :books
  end
end
