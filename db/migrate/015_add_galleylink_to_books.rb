class AddGalleylinkToBooks < ActiveRecord::Migration
  def self.up
    add_column :books, :galley_url, :string
  end

  def self.down
    remove_column :books, :galley_url
  end
end
