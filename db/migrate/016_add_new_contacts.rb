class AddNewContacts < ActiveRecord::Migration
  def self.up
    add_column :books, :editor_name, :string
    add_column :books, :editor_email, :string
    add_column :books, :marketing_name, :string
    add_column :books, :marketing_email, :string
  end

  def self.down
    remove_column :books, :editor_name
    remove_column :books, :editor_email
    remove_column :books, :marketing_name
    remove_column :books, :marketing_email
  end
end
