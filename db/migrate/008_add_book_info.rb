class AddBookInfo < ActiveRecord::Migration
  def self.up
    add_column :books, :selling_point, :text
    add_column :books, :format, :string
    add_column :books, :book_available_now, :boolean
    add_column :books, :preview_info_overide, :string
    add_column :books, :preview_format, :string
    add_column :books, :preview_available_now, :boolean
    add_column :books, :ship_date, :date
    add_column :books, :publisher, :string
    add_column :books, :contact_name, :string
    add_column :books, :contact_email, :string
  end

  def self.down
    remove_column :books, :selling_point
    remove_column :books, :format
    remove_column :books, :book_available_now
    remove_column :books, :preview_info_overide
    remove_column :books, :preview_format
    remove_column :books, :preview_available_now
    remove_column :books, :ship_date
    remove_column :books, :publisher
    remove_column :books, :contact_name
    remove_column :books, :contact_email
  end
end
